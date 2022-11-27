package top.w2gd.wit_niit;
import cn.leancloud.LCLogger;
import cn.leancloud.LeanCloud;
import cn.leancloud.im.LCIMOptions;
import io.flutter.app.FlutterApplication;

public class MyApplication extends FlutterApplication{
    private static final String LC_App_Id = "DtL8wv4T5fXStZXc3Vu8b1Ov-gzGzoHsz";
    private static final String LC_App_Key = "AcSQcHf3pkFPCDKQP27CSWwu";
    private static final String LC_Server_Url = "https://niit.w2gd.top";

    @Override
    public void onCreate() {
        super.onCreate();

        LCIMOptions.getGlobalOptions().setUnreadNotificationEnabled(true);

        LeanCloud.setLogLevel(LCLogger.Level.DEBUG);
        LeanCloud.initialize(this, LC_App_Id, LC_App_Key, LC_Server_Url);

    }
}