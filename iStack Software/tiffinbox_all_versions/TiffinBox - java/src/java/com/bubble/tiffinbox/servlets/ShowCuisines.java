/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.bubble.tiffinbox.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import com.bubble.tiffinbox.model.User;
import com.bubble.tiffinbox.model.DBConnectionFactory;
import com.bubble.tiffinbox.model.Cuisine;

/**
 *
 * @author bubble
 */
public class ShowCuisines extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if(user == null) {
            // If user is not logged in yet or is not admin, then you need to redirect to login page.
            // TODO : After login we need to re-direct to this page back.
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            // TODO : Write code to get All Cuisine information.
            List<Cuisine> cuisines = this.getCuisines();
            request.getSession().setAttribute("cuisines", cuisines);
            request.getRequestDispatcher("jspf/ShowCuisines.jsp").forward(request, response);
        }
    } 

       private List<Cuisine> getCuisines() {
        List<Cuisine> cuisines = new ArrayList<Cuisine>();
        String query = "SELECT id, name, description, price FROM cuisine";
        String message;
        try {
            Connection connection = DBConnectionFactory.getConnection();
            PreparedStatement pStatement = connection.prepareStatement(query);
            ResultSet rs = pStatement.executeQuery();
            while (rs.next()) {
                Cuisine cuisine = new Cuisine();
                cuisine.setId(rs.getInt("id"));
                cuisine.setName(rs.getString("name"));
                cuisine.setDesc(rs.getString("description"));
                cuisine.setPrice(rs.getInt("price"));
                cuisines.add(cuisine);
            }
        } catch (SQLException sqle) {
            message = "Failed to insert the record! " + sqle.getMessage();
        } catch (ClassNotFoundException cnfe) {
            message = "Failed to insert the record! " + cnfe.getMessage();
        }
        return cuisines;
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
