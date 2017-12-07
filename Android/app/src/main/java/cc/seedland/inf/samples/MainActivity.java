package cc.seedland.inf.samples;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import cc.seedland.inf.passport.PassportHome;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    private static final int REQUEST_CODE_PASSWORD = 1;
    private static final int REQUEST_CODE_LOGIN = 2;

    private Button passwordBtn;
    private Button logoutBtn;
    private ImageView avatarImv;
    private TextView nickNameTxv;
    private TextView mobileTxv;
    private TextView remarkTxv;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        avatarImv = findViewById(R.id.main_avatar);
        avatarImv.setOnClickListener(this);
        nickNameTxv = findViewById(R.id.main_nickname);
        mobileTxv = findViewById(R.id.main_mobile);
        remarkTxv = findViewById(R.id.main_remark);
        passwordBtn = findViewById(R.id.main_password);
        passwordBtn.setOnClickListener(this);
        logoutBtn = findViewById(R.id.main_logout);
        logoutBtn.setOnClickListener(this);

        updateState();

    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.main_password:
                PassportHome.getInstance().startModifyPassword(this, REQUEST_CODE_PASSWORD);
                break;
            case R.id.main_avatar:
                PassportHome.getInstance().startLoginByPassword(this, REQUEST_CODE_LOGIN);
                break;
            case R.id.main_logout:
                Config.saveNickName("");
                Config.saveUid("");
                Config.saveMobile("");
                PassportHome.getInstance().logout();
                updateState();
                break;
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if(resultCode == RESULT_OK) {
            switch (requestCode) {
                case REQUEST_CODE_LOGIN:
                    Bundle args = data.getBundleExtra("result");
                    Config.saveUid(args.getString("uid"));
                    Config.saveNickName(args.getString("nickname"));
                    Config.saveMobile(args.getString("mobile"));
                    updateState();
                    break;
                case REQUEST_CODE_PASSWORD:

                    break;
            }
        }

    }

    private void updateState() {
        if(!TextUtils.isEmpty(PassportHome.getInstance().getToken())) { // 已登录
            passwordBtn.setVisibility(View.VISIBLE);
            logoutBtn.setVisibility(View.VISIBLE);
            avatarImv.setImageResource(R.mipmap.ic_login_person);
            nickNameTxv.setText(Config.getNickName());
            mobileTxv.setText(Config.getMobile());
            remarkTxv.setVisibility(View.VISIBLE);
            remarkTxv.setText("uid:" + Config.getUid());
        }else {
            passwordBtn.setVisibility(View.GONE);
            logoutBtn.setVisibility(View.GONE);
            avatarImv.setImageResource(R.mipmap.ic_default_person);
            nickNameTxv.setText("未登录");
            mobileTxv.setText("-");
            remarkTxv.setText("点击头像登录");
        }
    }
}