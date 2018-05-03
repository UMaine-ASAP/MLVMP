package com.asap.phenom;

import android.support.v4.view.ViewPager;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.TextView;


public class HelpActivity extends ActionBarActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_help);
        getSupportActionBar().setDisplayShowCustomEnabled(true);
        getSupportActionBar().setCustomView(R.layout.action_bar);           //Set up Action Bar / back button
        TextView title = (TextView) findViewById(R.id.action_bar_text);
        title.setText("Help");
        ImageButton back = (ImageButton) findViewById(R.id.back_button);
        back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onBackPressed();
            }
        });
        TutorialPagerAdapter adapter = new TutorialPagerAdapter(this, false);
        ((ViewPager) findViewById(R.id.viewpager)).setAdapter(adapter);
        LinearLayout dots = (LinearLayout) findViewById(R.id.dots);

        for (int x=0; x < 5; x++)                                               //Create photo indicators for photos
        {
            Button button = new Button(getBaseContext());
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(dpTopx(15), dpTopx(15));
            params.setMargins(dpTopx(5), dpTopx(5), dpTopx(5), dpTopx(5));
            button.setLayoutParams(params);

            if (x==0)
                button.setBackgroundDrawable(getApplicationContext().getResources().getDrawable(R.drawable.light_dot));
            else
                button.setBackgroundDrawable(getApplicationContext().getResources().getDrawable(R.drawable.medium_dot_gray));
            dots.addView(button);
        }
        ((ViewPager) findViewById(R.id.viewpager)).setOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            int oldPosition = ((ViewPager) findViewById(R.id.viewpager)).getCurrentItem();

            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {
            }

            @Override
            public void onPageSelected(int position)                                    //When page is scrolled, modify page indicators
            {
                LinearLayout dots = (LinearLayout) findViewById(R.id.dots);
                dots.getChildAt(oldPosition).setBackgroundDrawable(getApplicationContext().getResources().getDrawable(R.drawable.medium_dot_gray));
                oldPosition = position;
                dots.getChildAt(position).setBackgroundDrawable(getApplicationContext().getResources().getDrawable(R.drawable.light_dot));
            }

            @Override
            public void onPageScrollStateChanged(int state) {
            }
        });
    }
    public int dpTopx(int dp)                                                    //Converts dp to pixels
    {
        return (int) (dp * getResources().getDisplayMetrics().density);
    }
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_help, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement


        return super.onOptionsItemSelected(item);
    }
    public void onBackPressed()
    {
        super.onBackPressed();
        overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_right);
    }
}
