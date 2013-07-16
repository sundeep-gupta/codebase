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
import javax.servlet.http.HttpSession;

import com.bubble.tiffinbox.model.User;
/**
 *
 * @author bubble
 */
public class ShowUsers extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        /* TODO: Check if the user is already logged in. If not redirect to login page */
        HttpSession session = request.getSession(false);
        if(session == null) {
            // If user is not logged in yet or is not admin, then you need to redirect to login page.
            // TODO : After login we need to re-direct to register page
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
        User user = (User) session.getAttribute("user");
        if(user == null) {
            // If user is not logged in yet or is not admin, then you need to redirect to login page.
            // TODO : After login we need to re-direct to register page
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else {
            // TODO : Write code to get All user's information.
            request.getRequestDispatcher("/ShowUsers.jsp").forward(request, response);
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
        return "Fetch Users information from the backend and redirect.";
    }// </editor-fold>

}
