package controllers.memos;

import java.io.IOException;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Account;
import models.Memo;
import utils.DBUtil;

/**
 * Servlet implementation class MemosEditServlet
 */
@WebServlet("/memos/edit")
public class MemosEditServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemosEditServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EntityManager em = DBUtil.createEntityManager();

        Memo m = em.find(Memo.class, Integer.parseInt(request.getParameter("id")));

        em.close();

        Account login_account = (Account)request.getSession().getAttribute("login_account");
        if(login_account.getId() == m.getAccount().getId()) {
            request.setAttribute("memo", m);
            request.setAttribute("_token", request.getSession().getId());
            request.getSession().setAttribute("memo_id", m.getId());
        }

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/memos/edit.jsp");
        rd.forward(request, response);
    }

}