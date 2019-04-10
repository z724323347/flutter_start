//package com.example.study1;
//
//import android.content.Intent;
//import android.os.Bundle;
//import androidx.annotation.Nullable;
//import androidx.appcompat.app.AppCompatActivity;
//import android.view.View;
//import android.widget.Button;
//import android.widget.TextView;
//import android.widget.Toast;
//
//import com.flutter.app.android.R;
//
//import butterknife.BindView;
//import butterknife.ButterKnife;
//import butterknife.OnClick;
//
//public class KotilnDemo extends AppCompatActivity {
//
//    @BindView(R.id.tv)
//    TextView tv;
//    @BindView(R.id.btn_native)
//    Button btnNative;
//    @BindView(R.id.btn)
//    Button btn;
//
//    @Override
//    protected void onCreate( Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//        setContentView(R.layout.ui_activity_kotlin);
//        ButterKnife.bind(this);
//
//    }
//
//    @OnClick({R.id.btn_native, R.id.btn})
//    public void onViewClicked(View view) {
//        switch (view.getId()) {
//            case R.id.btn_native:
//                Toast.makeText(this,btnNative.getText().toString(),Toast.LENGTH_SHORT).show();
//                break;
//            case R.id.btn:
//                Intent intent = new Intent(this,MainActivity.class);
//                startActivity(intent);
//                break;
//        }
//    }
//}
