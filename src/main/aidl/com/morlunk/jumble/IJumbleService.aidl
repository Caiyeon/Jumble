/*
 * Copyright (C) 2013 Andrew Comminos
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.morlunk.jumble;

import com.morlunk.jumble.model.IUser;
import com.morlunk.jumble.model.IChannel;
import com.morlunk.jumble.model.Server;
import com.morlunk.jumble.model.IMessage;
import com.morlunk.jumble.IJumbleObserver;
import com.morlunk.jumble.util.JumbleException;

interface IJumbleService {
    // Network
    int getConnectionState();
    JumbleException getConnectionError();
    boolean isReconnecting();
    void cancelReconnect();
    void disconnect();
    /**
     * Gets the TCP latency, in nanoseconds.
     */
    long getTCPLatency();
    /**
     * Gets the UDP latency, in nanoseconds.
     */
    long getUDPLatency();
    int getMaxBandwidth();
    int getCurrentBandwidth();

    // Server information
    int getServerVersion();
    String getServerRelease();
    String getServerOSName();
    String getServerOSVersion();

    // Session and users
    int getSession();
    IUser getSessionUser();
    IChannel getSessionChannel();
    Server getConnectedServer();
    IUser getUser(int id);
    IChannel getChannel(int id);
    IChannel getRootChannel();
    int getPermissions();

    // Audio actions and settings
    boolean isTalking();
    void setTalkingState(boolean talking);
    int getTransmitMode();
    int getCodec();

    // Bluetooth
    boolean usingBluetoothSco();
    void enableBluetoothSco();
    void disableBluetoothSco();

    // Server actions
    void joinChannel(int channel);
    void moveUserToChannel(int session, int channel);
    void createChannel(int parent, String name, String description, int position, boolean temporary);
    void sendAccessTokens(in List tokens);
    //void setTexture(byte[] texture);
    void requestBanList();
    void requestUserList();
    //void requestACL(int channel);
    void requestPermissions(int channel);
    void requestComment(int session);
    void requestAvatar(int session);
    void requestChannelDescription(int channel);
    void registerUser(int session);
    void kickBanUser(int session, String reason, boolean ban);
    IMessage sendUserTextMessage(int session, String message);
    IMessage sendChannelTextMessage(int channel, String message, boolean tree);
    void setUserComment(int session, String comment);
    void setPrioritySpeaker(int session, boolean priority);
    void removeChannel(int channel);
    //void addChannelLink(int channel, int link);
    //void requestChannelPermissions(int channel);
    void setMuteDeafState(int session, boolean mute, boolean deaf);
    void setSelfMuteDeafState(boolean mute, boolean deaf);
    void startRecording(String path);

    // Observation
    void registerObserver(in IJumbleObserver observer);
    void unregisterObserver(in IJumbleObserver observer);

    /**
     * Reconfigures the JumbleService with the given extras.
     * These are the same extras you would pass in for a connect call. This "patches" the service
     * only with the new extras specified.
     * @return true if the a reconnect is required for changes to take effect.
     */
    boolean reconfigure(in Bundle extras);
}