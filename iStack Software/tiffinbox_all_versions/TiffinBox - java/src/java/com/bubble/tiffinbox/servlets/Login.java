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
import javax.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import com.bubble.tiffinbox.model.DBConnectionFactory;
import com.bubble.tiffinbox.model.User;
/**
 *
 * @author bubble
 */
public class Login extends HttpServlet {
    private User fetchUser(String email) {
        User user = null;
        String query = "SELECT email, password, name, street1, street2, phone, area, city, "
                + "country, role FROM USER where email = ?";
        String message = "Invalid email / password";
        try {
            Connection connection = DBConnectionFactory.getConnection();
            PreparedStatement pStatement = connection.prepareStatement(query);
            pStatement.setString(1, email);
            ResultSet rs = pStatement.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setStreet1(rs.getString("street1"));
                user.setStreet2(rs.getString("street2"));
                user.setPhone(rs.getString("phone"));
                user.setArea(rs.getString("area"));
                user.setCity(rs.getString("city"));
                user.setCountry(rs.getString("country"));
                user.setRole(rs.getString("role"));
            }
        } catch (SQLException sqle) {
        } catch (ClassNotFoundException cnfe) {
        } finally {
            return user;
        }
    }
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String email       = request.getParameter("email");
        String password    = request.getParameter("password");
        User user          = this.fetchUser(email);
        String message     = "Invalid email / password";
        String redirectUrl = "jspf/index.jsp";
        if (user == null) {
            request.setAttribute("message", message);
        } else if (!user.getPassword().equals(password)) {
            request.setAttribute("message", message);
        } else {
            request.getSession().setAttribute("user", user);
            if (user.getRole().equals("admin")) {
                redirectUrl = "admin/jspf/index.jsp";
            }
        }
        request.getRequestDispatcher(redirectUrl).forward(request, response);
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
