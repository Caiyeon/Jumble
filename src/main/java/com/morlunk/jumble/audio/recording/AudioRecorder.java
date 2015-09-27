/*
 * Copyright (C) 2015 Tony Cai
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

package com.morlunk.jumble.audio.recording;

import com.morlunk.jumble.BuildConfig;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

/**
 * Created by tony on 2015-09-26.
 */
public class AudioRecorder implements Runnable {

    private final BlockingQueue<Frame> mInputQueue;
    private final BlockingQueue<Frame> mOutputQueue;
    private final IAudioSource mInputSource;
    private final IAudioSource mOutputSource;
    private final String mPath;
    private boolean mRecording;

    private IAudioListener mInputListener = new IAudioListener() {
        @Override
        public void onAudioPlayed(short[] frame, int frameSize) {
            mInputQueue.add(new Frame(frame, frameSize));
        }
    };

    private IAudioListener mOutputListener = new IAudioListener() {
        @Override
        public void onAudioPlayed(short[] frame, int frameSize) {
            mOutputQueue.add(new Frame(frame, frameSize));
        }
    };

    public AudioRecorder(String path, IAudioSource inputSource, IAudioSource outputSource) {
        mInputQueue = new LinkedBlockingQueue<>();
        mOutputQueue = new LinkedBlockingQueue<>();
        mInputSource = inputSource;
        mOutputSource = outputSource;
        mPath = path;
    }

    public IAudioListener getInputListener() {
        return mInputListener;
    }

    public IAudioListener getOutputListener() {
        return mOutputListener;
    }

    @Override
    public void run() {
        // open file
        while (mRecording) {
            if (!mInputSource.isAlive() && !mOutputSource.isAlive()) {
                // write empty, wait, return
            }
            if (mInputSource.isAlive()) {
                // dequeue a frame
            }
            if (mOutputSource.isAlive()) {
                // dequeue a frame
            }
            // write
        }
        // close file
    }

    public void start() {
        if (BuildConfig.DEBUG && mRecording) {
            throw new AssertionError("Attempt to start recording when already recording");
        }
        mRecording = true;
        new Thread(this).start();
    }

    public void stop() {
        if (BuildConfig.DEBUG && !mRecording) {
            throw new AssertionError("Attempt to end recording when not recording");
        }
        mRecording = false;
    }

    private static class Frame {
        public short[] frame;
        public int frameSize;

        public Frame(short[] frame, int frameSize) {
            this.frame = frame;
            this.frameSize = frameSize;
        }
    }
}
