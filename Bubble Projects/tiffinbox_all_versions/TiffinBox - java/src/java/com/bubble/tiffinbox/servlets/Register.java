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

import com.bubble.tiffinbox.model.UserRegistrationException;
import com.bubble.tiffinbox.model.User;
/**
 *
 * @author bubble
 */
public class Register extends HttpServlet {

    /**
     * Fetches the parameters from the request and creates the <code>User</code> object.
     *
     * @param request
     * @return <code>User<code> object if the parameters are valid. 'null' otherwise.
     */
    private User fetchUser(HttpServletRequest request) {
        try {
            User user = new User();
            user.setEmail(request.getParameter("email"));
            user.setPassword(request.getParameter("password"));
            user.setName(request.getParameter("name"));
            user.setPhone(request.getParameter("phone"));
            user.setStreet1(request.getParameter("street1"));
            user.setStreet2(request.getParameter("street2"));
            user.setArea(request.getParameter("area"));
            user.setCity(request.getParameter("city"));
            user.setCountry(request.getParameter("country"));
            return user;
        } catch (IllegalArgumentException iae) {
            return null;
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
        /* TODO : Write more cleaner logic */
        /* 1. Check if the parameters are present. if yes then register, store in session and redirect to index.jsp */
        /* 2. otherwise redirect to register.jsp */
        User user = this.fetchUser(request);
        // If no user then we need to redirect
        if (user == null) {
            // TODO : we do not have way to differentiate if we reach here first time or nth time after invalid value.
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            try {
                // Insert the user for registration
                // TODO : more complex logic to validate user email.
                user.insert();
                request.getSession(true).setAttribute("user", user);
                request.getRequestDispatcher("index.jsp").forward(request, response);
            } catch (UserRegistrationException ure) {
                // if we fail to register, we need to get the message and report that to user.
                request.setAttribute("message", ure.getMessage());
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        }
    }

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
    }

}
