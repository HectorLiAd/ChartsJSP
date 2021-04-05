<%-- 
    Document   : pie
    Created on : 01/04/2021, 08:57:18 AM
    Author     : LAB REDES
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.syscenterlife.com/echarts" prefix="echar" %>
<!DOCTYPE html>
<html >
    <head>



        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">    
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Bootstrap core CSS -->
        <link href="<%=request.getContextPath()%>/webdocument/echarts/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="<%=request.getContextPath()%>/webdocument/echarts/css/navbar-top-fixed.css" rel="stylesheet">
        <link href="<%=request.getContextPath()%>/webdocument/echarts/css/guide.css" rel="stylesheet">
        <link href="<%=request.getContextPath()%>/webdocument/echarts/css/prettify.css" rel="stylesheet">
        <echar:echartHeaderScript  />

    </head>

    <body class="guide">
        <%
            Object[][] dataValuesX =null;
            String query = "select cantidad,mes from data1 where tipo = 'Internacional';";

            try {

                Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
                Connection con = null;
                String sURL = "jdbc:mysql://big1ewzdjoc0lijtjnwz-mysql.services.clever-cloud.com:3306/big1ewzdjoc0lijtjnwz";
                con = DriverManager.getConnection(sURL, "ugh8ha8koeub4d8a", "qtdQY4SJwjchlVIoT5VO");

                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(query);
                int tamano = 0;

                while (rs.next()) {
                    out.write(rs.getString(1) + "\n");
                    tamano++;
                }

                rs = stmt.executeQuery(query);
                dataValuesX = new Object[tamano][2];

                int tamx = 0;
                
                while (rs.next()) {
                    dataValuesX[tamx][0] = rs.getDouble(1);
                    dataValuesX[tamx++][1] = rs.getString(2);
                }
                
                con.close();
                rs.close();
            } catch (Exception es) {
                System.err.println("errro");
            }
            String chartTitle = "Un usuario del sitio visita la fuente";
            String[] serieRadiusMinMax = {"20%", "70%"};//
            String[] serieCenterXY = {"50%", "50%"};//
            boolean roseType = false;

            String roseTypeValue = "radius";/*radius, area*/

        %>  

        <main role="main" class="container">
            <div class="content">
                <echar:echartPie idCharts="main" chartTitle="<%=chartTitle%>" dataValues="<%=dataValuesX%>"/>
                <echar:echartPie idCharts="main1" chartTitle="<%=chartTitle%>" dataValues="<%=dataValuesX%>" serieRadiusMinMax="<%=serieRadiusMinMax%>" />
                <echar:echartPie idCharts="main2" chartTitle="<%=chartTitle%>" dataValues="<%=dataValuesX%>" serieCenterXY="<%=serieCenterXY%>" roseType="true" />
                <!---->
            </div>
        </main>

        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->


    </body></html>