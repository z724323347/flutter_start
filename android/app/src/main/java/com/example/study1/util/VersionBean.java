package com.example.study1.util;

public class VersionBean {
    private String url;
    private String msg;
    private String name;

    @Override
    public String toString() {
        return "VersionBean{" +
                "url='" + url + '\'' +
                ", msg='" + msg + '\'' +
                ", name='" + name + '\'' +
                '}';
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
