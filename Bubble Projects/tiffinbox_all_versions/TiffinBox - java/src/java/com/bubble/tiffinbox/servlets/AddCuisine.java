/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.bubble.tiffinbox.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import com.bubble.tiffinbox.model.DBConnectionFactory;
import com.bubble.tiffinbox.model.Cuisine;

/**
 *
 * @author bubble
 */
public class AddCuisine extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        String name = request.getParameter("name");
        String desc = request.getParameter("desc");
        String sPrice = request.getParameter("price");
        String message = "";
        String sql = "INSERT INTO cuisine(name, description, price) VALUES(?, ?, ?)";
        String query = "SELECT name, description, price FROM CUISINE WHERE NAME = ?";
        Cuisine cuisine = new Cuisine();
        cuisine.setName(name);
        cuisine.setDesc(desc);
        cuisine.setPrice(Integer.parseInt(sPrice));
        try {
            Connection connection = DBConnectionFactory.getConnection();
            PreparedStatement pStatement = connection.prepareStatement(query);
            pStatement.setString(1, cuisine.getName());
            ResultSet rs = pStatement.executeQuery();
            if (rs.next()) {
               message =  "Record already exist!";
            } else {
                pStatement = connection.prepareStatement(sql);
                pStatement.setString(1, cuisine.getName());
                pStatement.setString(2, cuisine.getDesc());
                pStatement.setInt(3, cuisine.getPrice());
                int result = pStatement.executeUpdate();
                if (result == 1) {
                    message = "Cuisine Added Successfully!";
                } else {
                    message = "Failed to insert the record!";
                }
            }
        } catch (SQLException sqle) {
            message = "Failed to insert the record! " + sqle.getMessage();
        } catch (ClassNotFoundException cnfe) {
            message = "Failed to insert the record! " + cnfe.getMessage();
        }
        response.getWriter().print(message);
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
