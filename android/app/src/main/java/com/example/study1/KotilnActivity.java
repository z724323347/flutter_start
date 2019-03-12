package com.example.study1;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class KotilnActivity extends AppCompatActivity {

    @BindView(R.id.tv)
    TextView tv;
    @BindView(R.id.btn_native)
    Button btnNative;
    @BindView(R.id.btn)
    Button btn;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.ui_activity_kotlin);
        ButterKnife.bind(this);

    }

    @OnClick({R.id.btn_native, R.id.btn})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.btn_native:
                Toast.makeText(this,btnNative.getText().toString(),Toast.LENGTH_SHORT).show();
                break;
            case R.id.btn:
                Intent intent = new Intent(this,MainActivity.class);
                startActivity(intent);
                break;
        }
    }
}
