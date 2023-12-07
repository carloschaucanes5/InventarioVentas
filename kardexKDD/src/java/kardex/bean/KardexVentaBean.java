/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package kardex.bean;


import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;
import kardex.dao.ClienteDao;
import kardex.dao.KardexVentaDao;
import kardex.modelo.Cliente;
import kardex.modelo.CuentaCobrar;
import kardex.modelo.Empleado;
import kardex.modelo.Inventario;
import kardex.modelo.ItemVenta;
import kardex.modelo.KardexVenta;

/**
 *
 * @author Carlitos
 */
@ManagedBean
@ViewScoped
public class KardexVentaBean {
    private String cadenaNombre;
    private KardexVenta kardexVenta = new KardexVenta();
    private List<Inventario> listaInventario = new ArrayList<Inventario>();
    private Inventario itemInventario = new Inventario();
    private int itemCantidad;
    private double totalPago;
    private Cliente cliente = new Cliente();
    private String activarBotonCliente;
    private String activarBotonEjecutarVenta = "none";
    private boolean activarCamposCliente;
    private String detalleCxC;
    private String cadenaClienteNombre;
    private List<Cliente> listaClientes = new ArrayList<Cliente>();

    public String getCadenaClienteNombre() {
        return cadenaClienteNombre;
    }

    public void setCadenaClienteNombre(String cadenaClienteNombre) {
        this.cadenaClienteNombre = cadenaClienteNombre;
    }

  
    public List<Cliente> getListaClientes() {
        return listaClientes;
    }

    public void setListaClientes(List<Cliente> listaClientes) {
        this.listaClientes = listaClientes;
    }



    public String getCadenaNombre() {
        return cadenaNombre;
    }

    public void setCadenaNombre(String cadenaNombre) {
        this.cadenaNombre = cadenaNombre;
    }

    public KardexVenta getKardexVenta() {
        return kardexVenta;
    }

    public void setKardexVenta(KardexVenta kardexVenta) {
        this.kardexVenta = kardexVenta;
    }

    public List<Inventario> getListaInventario() {
        return listaInventario;
    }

    public void setListaInventario(List<Inventario> listaInventario) {
        this.listaInventario = listaInventario;
    }

    public Inventario getItemInventario() {
        return itemInventario;
    }

    public void setItemInventario(Inventario itemInventario) {
        this.itemInventario = itemInventario;
    }

    public int getItemCantidad() {
        return itemCantidad;
    }

    public void setItemCantidad(int itemCantidad) {
        this.itemCantidad = itemCantidad;
    }

    public double getTotalPago() {
        return totalPago;
    }

    public void setTotalPago(double totalPago) {
        this.totalPago = totalPago;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public String getActivarBotonCliente() {
        return activarBotonCliente;
    }

    public void setActivarBotonCliente(String activarBotonCliente) {
        this.activarBotonCliente = activarBotonCliente;
    }

    public String getActivarBotonEjecutarVenta() {
        return activarBotonEjecutarVenta;
    }

    public void setActivarBotonEjecutarVenta(String activarBotonEjecutarVenta) {
        this.activarBotonEjecutarVenta = activarBotonEjecutarVenta;
    }

    public boolean isActivarCamposCliente() {
        return activarCamposCliente;
    }

    public void setActivarCamposCliente(boolean activarCamposCliente) {
        this.activarCamposCliente = activarCamposCliente;
    }

    public String getDetalleCxC() {
        return detalleCxC;
    }

    public void setDetalleCxC(String detalleCxC) {
        this.detalleCxC = detalleCxC;
    }


    
    private boolean isPostBack()
    {
        boolean res;
        res = FacesContext.getCurrentInstance().isPostback();
        return res;
    }
    
    public void adicionarListaKardexItemVenta(Inventario itemInventario, int itemCantidad)
    {
        Double precioTotal = itemInventario.getPrecio_unitario() * itemCantidad;
        Double costoTotal = itemInventario.getCosto_unitario() * itemCantidad;
        ItemVenta itemVenta = new ItemVenta();
        itemVenta.setInventario(itemInventario);
        itemVenta.setCantidad(itemCantidad);
        itemVenta.setTotal_costo(costoTotal);
        itemVenta.setTotal_precio(precioTotal);
        if(verificarRepetidos(itemInventario)==false)
        {
            if(itemCantidad <= itemInventario.getExistencias())
            {
                this.kardexVenta.getListaItemsVenta().add(itemVenta);
                this.setTotalPago(calcularTotalVenta());
            }
            else
            {
                FacesContext.getCurrentInstance().addMessage(null,new  FacesMessage(FacesMessage.SEVERITY_ERROR,"Error:","La cantidad ingresada no debe superar  la existente"));
            }
        }
        else
        {
            FacesContext.getCurrentInstance().addMessage(null,new FacesMessage(FacesMessage.SEVERITY_WARN,"Advertencia","Este producto ya esta en la lista.Para modificar, elimina el item y vuelve  a ingresar"));
        }
    }
    
    public void eliminarItemVenta(ItemVenta itemVenta)
    {
        List<ItemVenta> items = this.kardexVenta.getListaItemsVenta();
        int j = 0;
        int b = 0;
        int pos = -1;
        while(j<items.size() && b==0)
        {
            if(items.get(j).getInventario().getCod_producto() == itemVenta.getInventario().getCod_producto())
            {
                pos = j;
                b=1;
            }
            j++;
        }
        if(b==1)
        {
            this.kardexVenta.getListaItemsVenta().remove(pos);
        }
    }
    
    public double calcularTotalVenta()
    {
      double total = 0;
      Iterator<ItemVenta> items = this.kardexVenta.getListaItemsVenta().iterator();
        while(items.hasNext() == true)
        {
            ItemVenta item = items.next();
            total = total + item.getTotal_precio();
        }
        return total;
    }
   
    public boolean verificarRepetidos(Inventario inv)
    {   
        int b=0;
        Iterator<ItemVenta> items = this.kardexVenta.getListaItemsVenta().iterator();
        while(items.hasNext() == true && b==0)
        {
            ItemVenta item = items.next();
            if(item.getInventario().getCod_producto() == inv.getCod_producto())
            {
                b=1;
            }
        }
        if(b==1)
        {
            return true;
        }
        else
        {
            return false;
        }
        
    }
    
   public void buscarProducto() throws Exception
    {
        try
        {
            KardexVentaDao dao = new KardexVentaDao();
            this.listaInventario = dao.getListarNombresProductos(cadenaNombre);
        }catch(Exception err)
        {
            throw err;
        }
    }
   
   public void leerIdInventario(Inventario inventario)
   {
       this.setItemInventario(inventario);
   }
   public void setNumeroFactura() throws Exception
   {
      try
       {  
           KardexVentaDao dao = new KardexVentaDao();
           this.kardexVenta.setNumero_factura(dao.getConsecutivoNumeroFactura());
       }
       catch(Exception err)
       {
           throw err;
       } 
   }
   
   public String registrarVentaContado(Empleado empleado)
   {
       try
       {
           KardexVentaDao dao = new KardexVentaDao();
           if(this.kardexVenta.getListaItemsVenta().size() > 0)
           {
               dao.registrarVenta(this.kardexVenta, 102, empleado);
               FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,"KardexKDD","Venta Almacenada con éxito"));
               kardexVenta.getListaItemsVenta().clear();
               this.setNumeroFactura();
               this.buscarProducto();
               this.totalPago = 0;
               return "kardex_venta?faces-redirect=true";
           }
           else
           {
               FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,"Error","No se han seleccionado productos"));
               return "";
           }
           
       }
       catch(Exception err)
       {
           FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,"Error:",""+err));
           return "";
       }finally
       {
           FacesContext.getCurrentInstance().getExternalContext().getFlash().setKeepMessages(true);
       }
   }
   //---------------------------------------------------------------------------
   public String registrarVentaCredito(Empleado empleado)
   {
       try
       {
           CuentaCobrar cxc = new CuentaCobrar();
           cxc.setNumero_factura(this.kardexVenta.getNumero_factura());
           cxc.setCedula_cliente(this.cliente.getCedula_cliente());
           cxc.setEstado("A");
           cxc.setSaldo_pendiente(this.totalPago);
           cxc.setDetalle(this.detalleCxC);
           KardexVentaDao dao = new KardexVentaDao();
           if(this.kardexVenta.getListaItemsVenta().size() > 0)
           {
               dao.registrarVentaCxc(this.kardexVenta, 103,cxc, empleado);
               FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,"KardexKDD","Venta Almacenada con éxito"));
               kardexVenta.getListaItemsVenta().clear();
               this.setNumeroFactura();
               this.buscarProducto();
               this.totalPago = 0;
               return "kardex_venta?faces-redirect=true";
           }
           else
           {
               FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,"Error","No se han seleccionado productos"));
               return "";
           }
           
       }
       catch(Exception err)
       {
           FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,"Error:",""+err));
           return "";
       }finally
       {
           FacesContext.getCurrentInstance().getExternalContext().getFlash().setKeepMessages(true);
       }
   }
   //-----------------------------listar Clientes-------------------------------
   public void buscarClienteCedula()
   {
       try
       {
           Cliente clien = new Cliente();
           ClienteDao dao = new ClienteDao();
           clien = dao.buscarClienteCedula(cliente.getCedula_cliente());
           if(clien == null)
           {
               FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,"Error:","El cliente no se encuentra registrado"));
               this.cliente.setNombres("");
               this.cliente.setApellidos("");
               this.cliente.setDireccion("");
               this.cliente.setTelefono("");
               this.activarBotonCliente = "show";
               this.activarCamposCliente = false;
               this.activarBotonEjecutarVenta = "none";
           }
           else
           {
               this.cliente = clien;
               this.activarBotonCliente = "none";
               this.activarBotonEjecutarVenta = "show";
               this.activarCamposCliente = true;
           }
       }
       catch(Exception err)
       {
           FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,"Error:",""+err));
       }finally
       {
           FacesContext.getCurrentInstance().getExternalContext().getFlash().setKeepMessages(true);
       } 
   }
   //---------------------------------------------------------------------------
   
   public void guardarCliente(Cliente cliente)
   {
       try
       {
          ClienteDao dao =  new ClienteDao();
          dao.registrar(cliente);
          this.buscarClienteCedula();
          FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,"KardexKdd:","Cliente almacenado con éxito")); 
       }
       catch(Exception err)
       {
           FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,"Error:",""+err));
       }finally
       {
           FacesContext.getCurrentInstance().getExternalContext().getFlash().setKeepMessages(true);
       } 
   }
   
   public void buscarClienteNombre() throws Exception
   {
       try
       {
           ClienteDao dao = new ClienteDao();
           this.listaClientes = dao.buscarClienteNombre(this.cadenaClienteNombre);
       }
       catch(Exception err)
       {
           FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,"Error:",""+err));
       }
   }
   
}