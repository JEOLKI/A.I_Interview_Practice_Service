<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <head>
    <script src="/js/jquery.js"></script>
    <script src="/js/recorder.js"></script>
    <script src="/js/Fr.voice.js"></script>
    <script src="/js/recorder2.js"></script>
    <%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
   </head>
   <body>
    <div id="content">
      <h2>Record, Play & Download Microphone Voice</h2>
      <audio controls src="" id="audio"></audio>
      <div style="margin:10px;">
        <a class="button" id="record">Record</a>
        <a class="button disabled one" id="stop">Reset</a>
        <a class="button disabled one" id="end">End</a>
        <a class="button disabled one" id="play">Play</a>
        <a class="button disabled one" id="download">Download</a>
        <a class="button disabled one" id="base64">Base64 URL</a>
        <a class="button disabled one" id="blob">BLOB</a>
        <a class="button disabled one" id="mp3">MP3 URL</a>
      </div>
      <input class="button" type="checkbox" id="live"/>
      <label for="live">Live Output</label>
      <style>
      .button{
        display: inline-block;
        vertical-align: middle;
        margin: 0px 5px;
        padding: 5px 12px;
        cursor: pointer;
        outline: none;
        font-size: 13px;
        text-decoration: none !important;
        text-align: center;
        color:#fff;
        background-color: #4D90FE;
        background-image: linear-gradient(top,#4D90FE, #4787ED);
        background-image: -ms-linear-gradient(top,#4D90FE, #4787ED);
        background-image: -o-linear-gradient(top,#4D90FE, #4787ED);
        background-image: linear-gradient(top,#4D90FE, #4787ED);
        border: 1px solid #4787ED;
        box-shadow: 0 1px 3px #BFBFBF;
      }
      a.button{
        color: #fff;
      }
      .button:hover{
        box-shadow: inset 0px 1px 1px #8C8C8C;
      }
      .button.disabled{
        box-shadow:none;
        opacity:0.7;
      }
      </style>
    </div>
   </body>
</html>