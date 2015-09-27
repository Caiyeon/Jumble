package com.morlunk.jumble.audio.recording;

/**
 * The audio listener informs the audio recorder when audio is played
 *
 * Created by tony on 2015-09-26.
 */
public interface IAudioListener {

    void onAudioPlayed(short[] frame, int frameSize);

}
