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

        <echar:echartHeaderScript  />

    </head>

    <body class="guide">

        Holas
        <%

            String chartTitle = "Salidas";

            String query = "SELECT  YEAR(CURRENT_DATE())-2 AS anho, r.* FROM ("
                    + "SELECT d.*, d2.cantidad2, d3.cantidad3, d4.cantidad4 FROM ("
                    + "SELECT data2.zona, data2.tipo, data2.cantidad FROM data2 WHERE anho=YEAR(CURRENT_DATE())-2 ) AS d LEFT JOIN ("
                    + "SELECT data2.zona, data2.tipo, data2.cantidad AS cantidad2 FROM data2 WHERE anho=YEAR(CURRENT_DATE())-3) AS d2 USING (zona, tipo) LEFT JOIN ("
                    + "SELECT data2.zona, data2.tipo, data2.cantidad AS cantidad3 FROM data2 WHERE anho=YEAR(CURRENT_DATE())-4) AS d3 USING (zona, tipo) LEFT JOIN ("
                    + "SELECT data2.zona, data2.tipo, data2.cantidad AS cantidad4 FROM data2 WHERE anho=YEAR(CURRENT_DATE())-5) AS d4 USING (zona, tipo)) AS r WHERE r.tipo = 'Salida';";

            try {

                Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
                Connection con = null;
                String sURL = "jdbc:mysql://big1ewzdjoc0lijtjnwz-mysql.services.clever-cloud.com:3306/big1ewzdjoc0lijtjnwz";
                con = DriverManager.getConnection(sURL, "ugh8ha8koeub4d8a", "qtdQY4SJwjchlVIoT5VO");

                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(query);
                int tamano = 0;

                while (rs.next()) {
                    tamano++;
                }

                out.write("Resul set");
                rs = stmt.executeQuery(query);

                double[] dataValues1 = new double[tamano];
                double[] dataValues2 = new double[tamano];
                double[] dataValues3 = new double[tamano];
                double[] dataValues4 = new double[tamano];

                String[] legendDataName = new String[4];
                int contador = 0, contAnho = 0;
                String[] ejeDataX = new String[tamano];
                while (rs.next()) {
                    if (contador == 0) {
                        legendDataName[contAnho++] = rs.getString("anho");
                        legendDataName[contAnho++] = String.valueOf(Integer.parseInt(rs.getString("anho")) - 1);
                        legendDataName[contAnho++] = String.valueOf(Integer.parseInt(rs.getString("anho")) - 2);
                        legendDataName[contAnho++] = String.valueOf(Integer.parseInt(rs.getString("anho")) - 3);
                    }
                    dataValues1[contador] = rs.getDouble("cantidad");
                    dataValues2[contador] = rs.getDouble("cantidad2");
                    dataValues3[contador] = rs.getDouble("cantidad3");
                    dataValues4[contador] = rs.getDouble("cantidad4");
                    ejeDataX[contador] = rs.getString("zona");
                    contador = contador + 1;
                }
                Object[] dataValues = {dataValues1, dataValues2, dataValues3, dataValues4};

                String[] ejeNameXY = {"Eje X", "Eje Y"};
                boolean[] seriesMarkPointMinMax = {false, false, false, false};
                boolean[] seriesMarkLineMedia = {false, false, false, false};
                //String[] seriesStackName ={"one","tro","three","Four"};            
                String[] seriesStackName = {"one", "one", "Two", "Two"};
                String echartsOriented = "horizontal";/*vertical,horizontal*/
                String x, y;
                if (echartsOriented.equals("horizontal")) {
                    x = "xAxis";
                    y = "yAxis";
                } else {
                    x = "yAxis";
                    y = "xAxis";
                }

        %>




        <div class="content">
            <echar:echartBarHistogram chartTitle="<%=chartTitle%>" dataValues="<%=dataValues%>" ejeDataX="<%=ejeDataX%>"
            idCharts="main" legendDataName="<%=legendDataName%>"/>
            <echar:echartBarHistogram chartTitle="<%=chartTitle%>" dataValues="<%=dataValues%>" ejeDataX="<%=ejeDataX%>"
            idCharts="main1" legendDataName="<%=legendDataName%>" echartsOriented="vertical"/>
        </div>

        <%    } catch (SQLException sqle) {
                System.out.println("Error en la ejecución:"
                        + sqle.getErrorCode() + " " + sqle.getMessage());
            }

        %>




    </body></html>