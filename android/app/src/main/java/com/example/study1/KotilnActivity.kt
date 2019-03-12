//package com.example.study1
//
//import android.content.Intent
//import android.os.Bundle
//import android.support.v7.app.AppCompatActivity
//import android.view.View
//import android.widget.Button
//import android.widget.TextView
//import android.widget.Toast
//
//import butterknife.BindView
//import butterknife.ButterKnife
//import butterknife.OnClick
//
//class KotilnActivity : AppCompatActivity() {
//
//    @BindView(R.id.tv)
//    internal var tv: TextView? = null
//    @BindView(R.id.btn)
//    internal var btnFlutter: Button? = null
//    @BindView(R.id.btn_native)
//    internal var btnNative: Button? = null
//
//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//
//        setContentView(R.layout.ui_activity_kotlin)
//        ButterKnife.bind(this)
//
//    }
//
//    @OnClick(R.id.btn_native, R.id.btn)
//    fun onViewClicked(view: View) {
//        when (view.id) {
//            R.id.btn_native ->
//                //                Toast toast = new Toast(this);
//                //                toast.setGravity(Gravity.CENTER,0,0);
//                //                toast.setText(btnNative.getText().toString());
//                //                toast.setDuration(Toast.LENGTH_SHORT);
//                //                toast.show();
//                Toast.makeText(this, btnNative!!.text.toString(), Toast.LENGTH_SHORT).show()
//            R.id.btn -> {
//                val intent = Intent(this@KotilnActivity, MainActivity::class.java)
//                startActivity(intent)
//            }
//        }
//    }
//}
