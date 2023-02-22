package com.lec.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class BoardDto {
	private int num; 
	private String writer;
	private String subject;
	private String content;
	private String email;
	private int readcount;
	private String pw;
	private int ref;
	private int ref_step;
	private int ref_indent;
	private String ip;
	private Timestamp rdate;
	public BoardDto() {
		super();
	}
	public BoardDto(int num, String writer, String subject, String content, String email, int readcount, String pw,
			int ref, int ref_step, int ref_indent, String ip, Timestamp rdate) {
		super();
		this.num = num;
		this.writer = writer;
		this.subject = subject;
		this.content = content;
		this.email = email;
		this.readcount = readcount;
		this.pw = pw;
		this.ref = ref;
		this.ref_step = ref_step;
		this.ref_indent = ref_indent;
		this.ip = ip;
		this.rdate = rdate;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getRef_step() {
		return ref_step;
	}
	public void setRef_step(int ref_step) {
		this.ref_step = ref_step;
	}
	public int getRef_indent() {
		return ref_indent;
	}
	public void setRef_indent(int ref_indent) {
		this.ref_indent = ref_indent;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public Timestamp getRdate() {
		return rdate;
	}
	public void setRdate(Timestamp rdate) {
		this.rdate = rdate;
	}
	@Override
	public String toString() {
		return "BoardDto [num=" + num + ", writer=" + writer + ", subject=" + subject + ", content=" + content
				+ ", email=" + email + ", readcount=" + readcount + ", pw=" + pw + ", ref=" + ref + ", ref_step="
				+ ref_step + ", ref_indent=" + ref_indent + ", ip=" + ip + ", rdate=" + rdate + "]";
	}
}