package com.fnrco.musaneda;
 
import android.content.ComponentName;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.net.Uri;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.util.Log;
import android.widget.Toast;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.oppwa.mobile.connect.checkout.dialog.CheckoutActivity;
import com.oppwa.mobile.connect.checkout.dialog.IPaymentFormListener;
import com.oppwa.mobile.connect.checkout.dialog.PaymentButtonFragment;
import com.oppwa.mobile.connect.checkout.meta.CheckoutSettings;
import com.oppwa.mobile.connect.checkout.meta.CheckoutSkipCVVMode;
import com.oppwa.mobile.connect.checkout.meta.CheckoutStorePaymentDetailsMode;
import com.oppwa.mobile.connect.exception.PaymentError;
import com.oppwa.mobile.connect.exception.PaymentException;
import com.oppwa.mobile.connect.payment.BrandsValidation;
import com.oppwa.mobile.connect.payment.CheckoutInfo;
import com.oppwa.mobile.connect.payment.ImagesRequest;
import com.oppwa.mobile.connect.payment.PaymentParams;
import com.oppwa.mobile.connect.payment.card.CardPaymentParams;
import com.oppwa.mobile.connect.payment.token.TokenPaymentParams;
import com.oppwa.mobile.connect.provider.Connect;
import com.oppwa.mobile.connect.provider.ITransactionListener;
import com.oppwa.mobile.connect.provider.Transaction;
import com.oppwa.mobile.connect.provider.TransactionType;
import com.oppwa.mobile.connect.service.ConnectService;
import com.oppwa.mobile.connect.service.IProviderBinder;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class MainActivity extends FlutterActivity implements ITransactionListener, MethodChannel.Result {

  private String CHANNEL = "com.fnrco.musaneda/channel";
  private String checkoutID = "";
  private MethodChannel.Result Result;
  private String type = "";
  private String number, holder, cvv, year, month, brand;
  private IProviderBinder binder;
  private String mode = "";
  private String stcPay = "";
  Transaction transaction = null;
  String MadaRegex = "";
  String madaRegexV = "";
  String madaRegexM = "";
  String brands = "";
  private Handler handler = new Handler(Looper.getMainLooper());

  boolean check(String ccNumber) {
    ccNumber = ccNumber.replaceAll("\\s", "");
    int sum = 0;
    boolean alternate = false;
    for (int i = ccNumber.length() - 1; i >= 0; i--) {
      int n = Integer.parseInt(ccNumber.substring(i, i + 1));
      if (alternate) {
        n *= 2;
        if (n > 9) {
          n = (n % 10) + 1;
        }
      }
      sum += n;
      alternate = !alternate;
    }

    return (sum % 10 == 0);
  }

  @Override
  public void success(final Object result) {
    handler.post(
      new Runnable() {
        @Override
        public void run() {
          Result.success(result);
        }
      }
    );
  }

  @Override
  public void error(  final String errorCode,  final String errorMessage, final Object errorDetails ) {
    handler.post(
      new Runnable() {
        @Override
        public void run() {
          Result.error(errorCode, errorMessage, errorDetails);
        }
      }
    );
  }

  @Override
  public void notImplemented() {
    handler.post(
      new Runnable() {
        @Override
        public void run() {
          Result.notImplemented();
        }
      }
    );
  }

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    super.configureFlutterEngine(flutterEngine);

    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL ).setMethodCallHandler(
        new MethodChannel.MethodCallHandler() {
          @Override
          public void onMethodCall(MethodCall call, MethodChannel.Result result) {
            Result = result;
            if (call.method.equals("get_hyperpay_response")) {
              type = call.argument("type");
              mode = call.argument("mode");
              checkoutID = call.argument("checkoutID");

              if (type.equals("ReadyUI")) {
                openCheckoutUI(checkoutID);
              } else {
                brands = call.argument("brand");
                stcPay = call.argument("stcPay");
                number = call.argument("card_number");
                holder = call.argument("holder_name");
                year = call.argument("year");
                month = call.argument("month");
                cvv = call.argument("cvv");
                madaRegexV = call.argument("MadaRegexV");
                madaRegexM = call.argument("MadaRegexM");
                openCustomUI(checkoutID);
              }
            } else {
              error("1", "Method name is not found", "");
            }
          }
        }
      );
   }

  private void openCheckoutUI(String checkoutId) {
    Set<String> paymentBrands = new LinkedHashSet<String>();
    if (brands.equals("mada")) {
      paymentBrands.add("MADA");
    } else {
      paymentBrands.add("VISA");
      paymentBrands.add("MASTER");
    }

    CheckoutSettings checkoutSettings = new CheckoutSettings(
      checkoutId,
      paymentBrands,
      Connect.ProviderMode.TEST
    )
      .setShopperResultUrl("com.fnrco.musaneda.payments://result");
    if (mode.equals("LIVE")) {
      checkoutSettings =
        new CheckoutSettings(
          checkoutId,
          paymentBrands,
          Connect.ProviderMode.LIVE
        )
          .setShopperResultUrl("com.fnrco.musaneda.payments://result");
    }

    ComponentName componentName = new ComponentName(
      getPackageName(),
      CheckoutBroadcastReceiver.class.getName()
    );

    /* Set up the Intent and start the checkout activity. */
    Intent intent = checkoutSettings.createCheckoutActivityIntent(
      this,
      componentName
    );
    startActivityForResult(intent, CheckoutActivity.REQUEST_CODE_CHECKOUT);
  }

  private void openCustomUI(String checkoutID) {
    Toast.makeText(getBaseContext(), "Waiting..", Toast.LENGTH_LONG).show();
    if (stcPay.equals("enabled")) {
      try {
        PaymentParams paymentParams = new PaymentParams(checkoutID, "STC_PAY");
        paymentParams.setShopperResultUrl(
          "com.fnrco.musaneda.payments://result"
        );
        Transaction transaction = new Transaction(paymentParams);
        binder.submitTransaction(transaction);
      } catch (PaymentException e) {
        e.printStackTrace();
      }
    } else {
      boolean result = check(number);
      if (!result) {
        Toast
          .makeText(
            getBaseContext(),
            "Card Number is Invalid",
            Toast.LENGTH_LONG
          )
          .show();
      } else if (!CardPaymentParams.isNumberValid(number)) {
        Toast
          .makeText(
            getBaseContext(),
            "Card Number is Invalid",
            Toast.LENGTH_LONG
          )
          .show();
      } else if (!CardPaymentParams.isHolderValid(holder)) {
        Toast
          .makeText(
            getBaseContext(),
            "Card Holder is Invalid",
            Toast.LENGTH_LONG
          )
          .show();
      } else if (!CardPaymentParams.isExpiryYearValid(year)) {
        Toast
          .makeText(
            getBaseContext(),
            "Expiry Year is Invalid",
            Toast.LENGTH_LONG
          )
          .show();
      } else if (!CardPaymentParams.isExpiryMonthValid(month)) {
        Toast
          .makeText(
            getBaseContext(),
            "Expiry Month is Invalid",
            Toast.LENGTH_LONG
          )
          .show();
      } else if (!CardPaymentParams.isCvvValid(cvv)) {
        Toast
          .makeText(getBaseContext(), "CVV is Invalid", Toast.LENGTH_LONG)
          .show();
      } else {
        String firstnumber = String.valueOf(number.charAt(0));
        // To add MADA
        if (brands.equals("mada")) {
 
            brand = "MADA";
 
        } else {
          if (firstnumber.equals("4")) {
            brand = "VISA";
          } else if (firstnumber.equals("5")) {
            brand = "MASTER";
          }
        }
        try {
          PaymentParams paymentParams = new CardPaymentParams(
            checkoutID,
            brand,
            number,
            holder,
            month,
            year,
            cvv
          );
          paymentParams.setShopperResultUrl(
            "com.fnrco.musaneda.payments://result"
          );
          Transaction transaction = new Transaction(paymentParams);
          binder.submitTransaction(transaction);
        } catch (PaymentException e) {
          e.printStackTrace();
        }
      }
    }
  }

  private ServiceConnection serviceConnection = new ServiceConnection() {
    @Override
    public void onServiceConnected(ComponentName name, IBinder service) {
      binder = (IProviderBinder) service;
      binder.addTransactionListener(MainActivity.this);
      /* we have a connection to the service */
      try {
        if (mode.equals("LIVE")) {
          binder.initializeProvider(Connect.ProviderMode.LIVE);
        } else {
          binder.initializeProvider(Connect.ProviderMode.TEST);
        }
      } catch (PaymentException ee) {
        ee.printStackTrace();
      }
    }

    @Override
    public void onServiceDisconnected(ComponentName name) {
      binder = null;
    }
  };

  @Override
  protected void onStart() {
    super.onStart();
    Intent intent = new Intent(this, ConnectService.class);
    startService(intent);
    bindService(intent, serviceConnection, Context.BIND_AUTO_CREATE);
  }

  @Override
  public void brandsValidationRequestSucceeded( BrandsValidation brandsValidation ) {}

  @Override
  public void brandsValidationRequestFailed(PaymentError paymentError) {}

  @Override
  public void imagesRequestSucceeded(ImagesRequest imagesRequest) {}

  @Override
  public void imagesRequestFailed() {}

  @Override
  public void paymentConfigRequestSucceeded(CheckoutInfo checkoutInfo) {}

  @Override
  public void paymentConfigRequestFailed(PaymentError paymentError) {}

  @Override
  public void transactionCompleted(Transaction transaction) {
    if (transaction == null) {
      return;
    }
    if (transaction.getTransactionType() == TransactionType.SYNC) {
      success("SYNC");
    } else {
      /* wait for the callback in the s */
      Uri uri = Uri.parse(transaction.getRedirectUrl());
      Intent intent2 = new Intent(Intent.ACTION_VIEW, uri);
      startActivity(intent2);
    }
  }

  @Override
  public void transactionFailed( Transaction transaction, PaymentError paymentError ) {}

  @Override
  protected void onActivityResult( int requestCode,  int resultCode,  Intent data ) {
    switch (resultCode) {
      case CheckoutActivity.RESULT_OK:
        /* transaction completed */
        Transaction transaction = data.getParcelableExtra(
          CheckoutActivity.CHECKOUT_RESULT_TRANSACTION
        );
        /* resource path if needed */
        String resourcePath = data.getStringExtra(
          CheckoutActivity.CHECKOUT_RESULT_RESOURCE_PATH
        );
        if (transaction.getTransactionType() == TransactionType.SYNC) {
          /* check the result of synchronous transaction */
          success("SYNC");
        } else {
          /* wait for the asynchronous transaction callback in the onNewIntent() */
        }
        break;
      case CheckoutActivity.RESULT_CANCELED:
        /* shopper canceled the checkout process */
        Toast.makeText(getBaseContext(), "canceled", Toast.LENGTH_LONG).show();
        error("2", "Canceled", "");
        break;
      case CheckoutActivity.RESULT_ERROR:
        /* error occurred */
        PaymentError error = data.getParcelableExtra(
          CheckoutActivity.CHECKOUT_RESULT_ERROR
        );
        Toast.makeText(getBaseContext(), "error", Toast.LENGTH_LONG).show();
        Log.e("errorrr", String.valueOf(error.getErrorInfo()));
        Log.e("errorrr2", String.valueOf(error.getErrorCode()));
        Log.e("errorrr3", String.valueOf(error.getErrorMessage()));
        Log.e("errorrr4", String.valueOf(error.describeContents()));
        error("3", "Checkout Result Error", "");
    }
  }

  @Override
  protected void onNewIntent(Intent intent) {
    super.onNewIntent(intent);
    if (intent.getScheme().equals("com.fnrco.musaneda")) {
      success("success");
    }
  }
}