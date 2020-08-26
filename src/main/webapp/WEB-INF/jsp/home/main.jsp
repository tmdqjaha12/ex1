<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="메인" />
<%@ include file="../part/head.jspf"%>

<div class="background-home" style="background-color:#ebebf1; width:100%; height:700px; padding:50px; padding-top:80px;">
	<ul class="board-item-box con" style="background-color: white; width:1000px; height:500px; border:2px solid #6b6880; overflow-x:hidden; overflow-y:auto;">
	<c:forEach items="${boards}" var="board">
		
		<li class="cate-item" style="padding:10px; display:inline-block;"><a href="/usr/article/${board.code }-list">${board.name }</a></li>
		<style>.cate-item > a:hover {color:blue;}  .cate-item > a:active {color:red;}</style>
	</c:forEach>
		
	
	<!-- 	Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat quae dignissimos culpa incidunt debitis iusto inventore dolor cumque illo nam. Blanditiis praesentium quod sed tempore deleniti illum quae beatae maxime.
		 -->
	</ul>
</div>

<%@ include file="../part/foot.jspf"%>