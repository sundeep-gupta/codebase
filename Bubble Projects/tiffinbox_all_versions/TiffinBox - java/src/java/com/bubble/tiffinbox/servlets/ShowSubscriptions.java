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
import com.bubble.tiffinbox.model.DBConnectionFactory;
import com.bubble.tiffinbox.model.Cuisine;
import com.bubble.tiffinbox.model.Subscription;
import com.bubble.tiffinbox.model.User;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.List;
import java.util.ArrayList;

/**
 *
 *
 * @author bubble
 */
public class ShowSubscriptions extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        User user = (User)request.getSession().getAttribute("user");
        if ( user == null || ! user.getRole().equals("admin") ) {

        } else {
            List<Subscription> subscriptions = this.getSubscriptions();
            request.getSession().setAttribute("subscriptions", subscriptions);
            request.getRequestDispatcher("jspf/ShowSubscriptions.jsp").forward(request, response);
        }
    }

    private List<Subscription> getSubscriptions() {
        List<Subscription> subscriptions = new ArrayList<Subscription>();
        try {
            Connection connection = DBConnectionFactory.getConnection();
            String query = "SELECT * FROM subscription";
            PreparedStatement pStatement = connection.prepareStatement(query);
            ResultSet rs = pStatement.executeQuery();
            while(rs.next()) {
                Subscription subscription = new Subscription();
                subscription.setId(rs.getInt("id"));
                subscription.setName(rs.getString("name"));
                subscription.setDesc(rs.getString("description"));
                subscription.setPrice(rs.getInt("price"));
                subscriptions.add(subscription);
            }
        } catch (SQLException sqle) {

        } catch (ClassNotFoundException cnfe) {

        } finally {
            return subscriptions;
        }
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
