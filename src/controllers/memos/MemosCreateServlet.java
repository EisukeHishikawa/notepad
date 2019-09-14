package controllers.memos;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Account;
import models.Memo;
import models.validators.MemoValidator;
import utils.DBUtil;

/**
 * Servlet implementation class MemosCreateServlet
 */
@WebServlet("/memos/create")
public class MemosCreateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemosCreateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String _token = (String)request.getParameter("_token");
        if(_token != null && _token.equals(request.getSession().getId())) {
            EntityManager em = DBUtil.createEntityManager();

            Memo m = new Memo();

            m.setAccount((Account)request.getSession().getAttribute("login_account"));

            Date memo_date = new Date(System.currentTimeMillis());
            String md_str = request.getParameter("memo_date");
            if(md_str != null && !md_str.equals("")) {
                memo_date = Date.valueOf(request.getParameter("memo_date"));
            }
            m.setMemo_date(memo_date);

            m.setTitle(request.getParameter("title"));
            m.setContent(request.getParameter("content"));


            Timestamp currentTime = new Timestamp(System.currentTimeMillis());
            m.setCreated_at(currentTime);
            m.setUpdated_at(currentTime);

            List<String> errors = MemoValidator.validate(m);
            if(errors.size() > 0) {
                em.close();

                request.setAttribute("_token", request.getSession().getId());
                request.setAttribute("memo", m);
                request.setAttribute("errors", errors);

                RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/memos/new.jsp");
                rd.forward(request, response);
            } else {
                em.getTransaction().begin();
                em.persist(m);
                em.getTransaction().commit();
                em.close();
                request.getSession().setAttribute("flush", "登録が完了しました。");

                response.sendRedirect(request.getContextPath() + "/memos/index");
            }
        }
    }

}