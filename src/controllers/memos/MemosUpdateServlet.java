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

import models.Memo;
import models.validators.MemoValidator;
import utils.DBUtil;

/**
 * Servlet implementation class MemosUpdateServlet
 */
@WebServlet("/memos/update")
public class MemosUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemosUpdateServlet() {
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

            Memo m = em.find(Memo.class, (Integer)(request.getSession().getAttribute("memo_id")));

            m.setMemo_date(Date.valueOf(request.getParameter("memo_date")));
            m.setTitle(request.getParameter("title"));
            m.setContent(request.getParameter("content"));
            m.setUpdated_at(new Timestamp(System.currentTimeMillis()));

            List<String> errors = MemoValidator.validate(m);
            if(errors.size() > 0) {
                em.close();

                request.setAttribute("_token", request.getSession().getId());
                request.setAttribute("memo", m);
                request.setAttribute("errors", errors);

                RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/memos/edit.jsp");
                rd.forward(request, response);
            } else {
                em.getTransaction().begin();
                em.getTransaction().commit();
                em.close();
                request.getSession().setAttribute("flush", "更新が完了しました。");

                request.getSession().removeAttribute("memo_id");

                response.sendRedirect(request.getContextPath() + "/memos/index");
            }
        }
    }

}