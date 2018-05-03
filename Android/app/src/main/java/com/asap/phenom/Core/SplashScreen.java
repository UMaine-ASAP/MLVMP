package com.asap.phenom.Core;

import com.asap.phenom.R;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Configuration;
import android.preference.PreferenceManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;


public class SplashScreen extends AppCompatActivity {
    final String tutorialShownPreferences = "tutorialShown";
    SharedPreferences mreferences;
    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash_screen);
        getSupportActionBar().setDisplayShowCustomEnabled(true);                //Set up action bar
        getSupportActionBar().setCustomView(R.layout.action_bar);
        TextView title = (TextView) findViewById(R.id.action_bar_text);
        title.setText("Welcome");
        ImageButton back = (ImageButton) findViewById(R.id.back_button);
        back.setVisibility(View.GONE);
        ImageView logo = (ImageView) findViewById(R.id.logo);

        int screenSize = getApplicationContext().getResources().getConfiguration().screenLayout & Configuration.SCREENLAYOUT_SIZE_MASK;
        if (screenSize == Configuration.SCREENLAYOUT_SIZE_LARGE || screenSize == Configuration.SCREENLAYOUT_SIZE_XLARGE)
            logo.setBackground(getApplicationContext().getResources().getDrawable(R.drawable.splash_large));
        else
            logo.setBackground(getApplicationContext().getResources().getDrawable(R.drawable.splash));


    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is pres    ent.
        getMenuInflater().inflate(R.menu.menu_splash_screen, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item)
    {
        return true;
    }
    public void toMain(View v)
    {
        Intent intent = new Intent(this, MainActivity.class);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in_right, R.anim.slide_out_left);
    }

    @Override
    public void onStart()
    {
        super.onStart();
        mreferences = PreferenceManager.getDefaultSharedPreferences(this);
        Boolean tutorialShown = mreferences.getBoolean(tutorialShownPreferences, false);
        if (!tutorialShown)
        {
            ((Button) findViewById(R.id.entrance_button)).setText("Proceed to Tutorial");
        }
        else
            ((Button) findViewById(R.id.entrance_button)).setText("Explore Aquatic Phenomena");


    }
}
