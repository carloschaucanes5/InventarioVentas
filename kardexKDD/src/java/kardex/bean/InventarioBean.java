/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package kardex.bean;


import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;
import kardex.dao.InventarioDao;
import kardex.modelo.Inventario;

/**
 *
 * @author Carlitos
 */
@ManagedBean
@ViewScoped
public class InventarioBean {
    
    private Inventario inventario = new Inventario();
    /*private List<Proveedor> listaProveedores = new ArrayList<Proveedor>();
    private List<Laboratorio> listaLaboratorios = new ArrayList<Laboratorio>();*/
    
 
    public Inventario getInventario() {
        return inventario;
    }

    public void setInventario(Inventario inventario) {
        this.inventario = inventario;
    }

 
    
   
    
    
   /* public void listarProveedores(Boolean ajax) throws Exception
    {
        try
        {
            if(ajax==false)
            {
                if(isPostBack()==false)
                {
                    InventarioDao dao = new InventarioDao();
                    this.listaProveedores = dao.getListaProveedores();
                }
            }
            else
            {
                    InventarioDao dao = new InventarioDao();
                    this.listaProveedores = dao.getListaProveedores();
            }
        }catch(Exception e)
        {
            throw e;
        }
    }*/
    
    /*public void listarLaboratorios(Boolean ajax) throws Exception
    {
        try
        {
            if(ajax==false)
            {
                if(isPostBack()==false)
                {
                    InventarioDao dao = new InventarioDao();
                    this.listaLaboratorios = dao.getListaLaboratorios();
                }
            }
            else
            {
                    InventarioDao dao = new InventarioDao();
                    this.listaLaboratorios = dao.getListaLaboratorios();
            }
        }catch(Exception e)
        {
            throw e;
        }
    }*/
    
    
   private boolean isPostBack()
    {
        boolean res;
        res = FacesContext.getCurrentInstance().isPostback();
        return res;
    }
    
   public void registrarInventario() throws Exception
    {
        try
        {
            InventarioDao dao = new InventarioDao();
            dao.conectar();
            dao.registrarInventario(this.inventario);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,"Aviso","Producto almacenado con exito"));
        }
        catch(Exception e)
        {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_FATAL,"Aviso","Error:"+e));
        }finally
        {
            FacesContext.getCurrentInstance().getExternalContext().getFlash().setKeepMessages(true);
        }
    }
   
}

