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
import com.bubble.tiffinbox.model.Cuisine;
import com.bubble.tiffinbox.model.DBConnectionFactory;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
/**
 *
 * @author bubble
 */
public class EditCuisine extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String desc = request.getParameter("desc");
        String sPrice = request.getParameter("price");
        String message = "";
        String sql = "UPDATE cuisine SET description=?, price=? WHERE ID = ?";
        Cuisine cuisine = new Cuisine();
        cuisine.setName(name);
        cuisine.setDesc(desc);
        cuisine.setPrice(Integer.parseInt(sPrice));
        cuisine.setId(Integer.parseInt(id));

        try {
            Connection connection = DBConnectionFactory.getConnection();
            PreparedStatement pStatement = connection.prepareStatement(sql);
            pStatement.setString(1, cuisine.getDesc());
            pStatement.setInt(2, cuisine.getPrice());
            pStatement.setInt(3, cuisine.getId());
            if (pStatement.executeUpdate() == 0) {
                message = "Record does not exist!";
            } else {
                message = "Record updated successfully!";
            }
        } catch (SQLException sqle) {
            message = "Failed to update the record! " + sqle.getMessage();
        } catch (ClassNotFoundException cnfe) {
            message = "Failed to update the record! " + cnfe.getMessage();
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
