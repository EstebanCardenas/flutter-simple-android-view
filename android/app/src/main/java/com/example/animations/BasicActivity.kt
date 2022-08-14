package com.example.animations

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.example.animations.databinding.ActivityBasicBinding

class BasicActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val binding: ActivityBasicBinding = ActivityBasicBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.goBackButton.setOnClickListener {
            finish()
        }
    }
}