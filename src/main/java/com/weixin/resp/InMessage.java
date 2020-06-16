package com.weixin.resp;

/**
 * 消息基类（公众帐号 -> 普通用户）
 */
public class InMessage {

	private String ToUserName;

	private String FromUserName;

	private long CreateTime;

	private String MsgType;
	
	private String Event;
	
	private String Eventkey;
	
	public String getEvent() {
		return Event;
	}

	public void setEvent(String event) {
		this.Event = event;
	}

	public String getEventkey() {
		return Eventkey;
	}

	public void setEventkey(String eventkey) {
		this.Eventkey = eventkey;
	}

	public String getToUserName() {
		return ToUserName;
	}

	public void setToUserName(String toUserName) {
		ToUserName = toUserName;
	}

	public String getFromUserName() {
		return FromUserName;
	}

	public void setFromUserName(String fromUserName) {
		FromUserName = fromUserName;
	}

	public long getCreateTime() {
		return CreateTime;
	}

	public void setCreateTime(long createTime) {
		CreateTime = createTime;
	}

	public String getMsgType() {
		return MsgType;
	}

	public void setMsgType(String msgType) {
		MsgType = msgType;
	}

}
