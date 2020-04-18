package dev.vizo.payme;

import java.util.HashMap;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.EventChannel;
import io.flutter.embedding.engine.FlutterEngine;

import com.paymeservice.android.PayMe;
import com.paymeservice.android.error.PayMeError;
import com.paymeservice.android.model.PaySaleRequest;
import com.paymeservice.android.model.PaySaleResponse;
import com.paymeservice.android.model.Settings;
import static com.paymeservice.android.model.Settings.Environment.STAGING;
import static com.paymeservice.android.model.Settings.Environment.PRODUCTION;

/** PaymePlugin */
public class PaymePlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native
  /// Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine
  /// and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private boolean initialized = false;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "payme");
    channel.setMethodCallHandler(this);
  }

  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "payme");
    channel.setMethodCallHandler(new PaymePlugin());
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("init")) {
      try {
        final String sellerKey = call.argument("sellerKey");
        final String environment = call.argument("environment");
        PayMe.initialize(new Settings(sellerKey, environment == "PRODUCTION" ? PRODUCTION : STAGING));
        initialized = true;
        result.success(true);
        return;
      } catch (Exception e) {
        result.error("EXCEPTION", "An exception ocurred in the initialization", e);
        return;
      }
    }

    if (!initialized) {
      result.error("NOT_INITIALIZED", "PayMe Environment is not initialized", null);
      return;
    }

    if (call.method.equals("paySale")) {
      final HashMap paySaleRequestMap = call.argument("paySaleRequest");
      paySale(paySaleRequestMap, result);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  public void paySale(HashMap paySaleRequestMap, final Result result) {
    final PaySaleRequest request = new PaySaleRequest();

    request.setBuyerName((String) paySaleRequestMap.get("buyerName"));
    request.setBuyerPhone((String) paySaleRequestMap.get("buyerPhone"));
    request.setBuyerEmail((String) paySaleRequestMap.get("buyerEmail"));
    request.setBuyerSocialID((String) paySaleRequestMap.get("buyerSocialID"));
    request.setInstallments((String) paySaleRequestMap.get("installments"));
    request.setPaymeSaleId((String) paySaleRequestMap.get("paymentSaleID"));

    request.setCreditCardNumber((String) paySaleRequestMap.get("creditCardNumber"));
    request.setCreditCardCVV((String) paySaleRequestMap.get("creditCardCVV"));
    request.setCreditCardExp((String) paySaleRequestMap.get("creditCardExp"));

    try {
      isValid(request);
    } catch (Exception e) {
      throw e;
    }

    PayMe.TransactionListener transactionListener = new PayMe.TransactionListener<PaySaleResponse>() {
      @Override
      public void onSuccess(PaySaleResponse response) {
        final HashMap r = new HashMap();
        r.put("statusCode", response.getStatusCode());
        r.put("paymeStatus", response.getPaymeStatus());
        r.put("paymeSaleId", response.getPaymeSaleId());
        r.put("paymeSaleCode", response.getPaymeSaleCode());
        r.put("saleCreated", response.getSaleCreated());
        r.put("paymeSaleStatus", response.getPaymeSaleStatus());
        r.put("currency", response.getCurrency());
        r.put("transactionId", response.getTransactionId());
        r.put("tokenSale", response.getTokenSale());
        r.put("price", response.getPrice());
        r.put("paymeSignature", response.getPaymeSignature());
        r.put("paymeTransactionId", response.getPaymeTransactionId());
        r.put("paymeTransactionTotal", response.getPaymeTransactionTotal());
        r.put("paymeTransactionCardBrand", response.getPaymeTransactionCardBrand());
        r.put("paymeTransactionAuthNumber", response.getPaymeTransactionAuthNumber());
        r.put("buyerName", response.getBuyerName());
        r.put("buyerEmail", response.getBuyerEmail());
        r.put("buyerPhone", response.getBuyerPhone());
        r.put("buyerCardMask", response.getBuyerCardMask());
        r.put("buyerCardExp", response.getBuyerCardExp());
        r.put("buyerSocialId", response.getBuyerSocialId());
        r.put("installments", response.getInstallments());
        r.put("salePaidDate", response.getSalePaidDate());
        r.put("saleReleaseDate", response.getSaleReleaseDate());
        result.success(r);
      }

      @Override
      public void onFailed(Exception exception, PayMeError error) {
        if (error != null) {
          result.error(String.valueOf(error.getStatusErrorCode()), error.getStatusErrorDetails(), error.getStatusAdditionalInfo());
        } else if (exception != null) {
          result.error("EXCEPTION", "EXCEPTION", exception);
        } else {
          result.error("UNDEFINED", "UNKNOWN_ERROR", "UNKNOWN_ERROR");
        }
      }
    };

    PayMe.paySale(request, transactionListener);
    return;
  }

  public boolean isValid(PaySaleRequest request) {

    if (!PayMe.Validator.isEmail(request.getBuyerEmail())) {
      throw new IllegalArgumentException("INVALID_EMAIL");
    }

    return true;
  }
}
