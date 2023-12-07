/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package kardex.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import kardex.modelo.CuentaCobrar;
import kardex.modelo.Empleado;
import kardex.modelo.Inventario;
import kardex.modelo.ItemVenta;
import kardex.modelo.KardexVenta;

/**
 *
 * @author Carlitos
 */
public class KardexVentaDao extends Dao {
    
    public void registrarVenta(KardexVenta kardexVenta, int codigoTransaccion, Empleado empleado) throws Exception
    {      
        try
        {
          this.conectar();
          this.getCn().setAutoCommit(false);
          PreparedStatement st = null,st1=null,st2=null,st3=null;
          String sql = "", sql1 = "", sql2 = "", sql3=""; 
          //-------------------------------------------------------------------          
          sql3 = "insert into factura_venta(numero_factura,fecha_factura,hora_factura,cedula_empleado)"+
          "values("+kardexVenta.getNumero_factura()+",'"+this.getFecha()+"','"+this.getHora()+"','"+empleado.getCedula_empleado()+"')";
          st3  = this.getCn().prepareStatement(sql3);
          st3.executeUpdate();
          //-------------------------------------------------------------------
          Iterator<ItemVenta> listaItems = kardexVenta.getListaItemsVenta().iterator();
          while(listaItems.hasNext() ==true)
          {
            int existencias = 0;
            ItemVenta item = listaItems.next();
            //----------------------------------------------------------------------------------------------
            sql=""+
            "insert into kardex_venta"+
            "(numero_factura,cod_tipo_transaccion,cod_producto,"+
            "cantidad,total_costo,total_precio)"+
            "values("+kardexVenta.getNumero_factura()+","+codigoTransaccion+","+item.getInventario().getCod_producto()+","+
            ""+item.getCantidad()+","+
            ""+item.getTotal_costo()+","+item.getTotal_precio()+")";
            st  = this.getCn().prepareStatement(sql);
            st.executeUpdate();
            existencias =  item.getInventario().getExistencias()-item.getCantidad();  
            //--------------------------------------------------------------------------------------------
            sql1 = "update inventario set existencias = "+existencias+" where cod_producto = "+item.getInventario().getCod_producto()+"";
            st1 = this.getCn().prepareStatement(sql1);
            st1.executeUpdate();
          }
          //-----------------------------------------------------------------------------------------------
          sql2 = "update consecutivo set actual = "+kardexVenta.getNumero_factura()+" where id_consecutivo=1";
          st2 = this.getCn().prepareStatement(sql2);
          st2.executeUpdate();
          //-----------------------------------------------------------------------------------------------        
          st.close();
          st1.close();
          st2.close();
          st3.close();
          this.verificarExistenciasCeros();
          this.getCn().commit();
        }catch(Exception e)
        {
           this.getCn().rollback();
           throw  e;
        }finally{
           this.cerrarConexion();
        }
    } 
    
    public void registrarVentaCxc(KardexVenta kardexVenta, int codigoTransaccion, CuentaCobrar cxc , Empleado empleado) throws Exception
    {      
        try
        {
          this.conectar();
          this.getCn().setAutoCommit(false);
          PreparedStatement st = null,st1=null,st2=null,st3 = null, st4 = null;
          String sql="",sql1 = "", sql2 = "", sql3 = "", sql4 = null;
          //-------------------------------------------------------------------          
          sql4 = "insert into factura_venta(numero_factura,fecha_factura,hora_factura,cedula_empleado)"+
          "values("+kardexVenta.getNumero_factura()+",'"+this.getFecha()+"','"+this.getHora()+"','"+empleado.getCedula_empleado()+"')";
          st4  = this.getCn().prepareStatement(sql4);
          st4.executeUpdate();
          //-------------------------------------------------------------------
          Iterator<ItemVenta> listaItems = kardexVenta.getListaItemsVenta().iterator();
          while(listaItems.hasNext() ==true)
          {
            int existencias = 0;
            ItemVenta item = listaItems.next();
            //-----------------------------------------------------------------------------------------------
            sql=""+
            "insert into kardex_venta"+
            "(numero_factura,cod_tipo_transaccion,cod_producto,"+
            "cantidad,total_costo,total_precio)"+
            "values("+kardexVenta.getNumero_factura()+","+codigoTransaccion+","+item.getInventario().getCod_producto()+","+
            ""+item.getCantidad()+","+
            ""+item.getTotal_costo()+","+item.getTotal_precio()+")";
            st  = this.getCn().prepareStatement(sql);
            st.executeUpdate();
            //----------------------------------------------------------------------------------------------
            existencias =  item.getInventario().getExistencias()-item.getCantidad();  
            sql1 = "update inventario set existencias = "+existencias+" where cod_producto = "+item.getInventario().getCod_producto()+"";
            st1 = this.getCn().prepareStatement(sql1);
            st1.executeUpdate();
          }
          //------------------------------------------------------------------------------------------------
          sql2 = "update consecutivo set actual = "+kardexVenta.getNumero_factura()+" where id_consecutivo=1";
          st2 = this.getCn().prepareStatement(sql2);
          st2.executeUpdate();
          //-----------------------------------------------------------------------------------------------
          sql3= "insert into cuentas_cobrar(numero_factura,cedula_cliente,estado,saldo_pendiente,detalle)values(?,?,?,?,?)";
          st3  = this.getCn().prepareStatement(sql3);

            st3.setInt(1, cxc.getNumero_factura());
            st3.setString(2, cxc.getCedula_cliente());
            st3.setString(3, cxc.getEstado());
            st3.setDouble(4, cxc.getSaldo_pendiente());
            st3.setString(5, cxc.getDetalle());
            st3.executeUpdate();   
         //-----------------------------------------------------------------------------------------
            
         //------------------------------------------------------------------------------------------   
          st.close();
          st1.close();
          st2.close();
          st3.close();
          this.verificarExistenciasCeros();
          //---------------------------------------------------------------------------
          this.getCn().commit();
        }catch(Exception e)
        {
           this.getCn().rollback();
           throw  e;
        }finally{
           this.cerrarConexion();
        }
    } 
    
    //verificar si el inventario tiene existencias con ceros y eliminar las entradas
    //que corresponden a ese Id.
    public void verificarExistenciasCeros() throws Exception
    {
        List<Integer> listaId = new ArrayList<Integer>();
        String sql1 = "", sql2="";
        PreparedStatement st1 = null,st2 = null;
        ResultSet rs1 = null;
        try
        {
            sql1 = "select * from inventario where existencias = 0";
            st1 = this.getCn().prepareStatement(sql1);
            rs1 =  st1.executeQuery();
            while(rs1.next() == true)
            {
                listaId.add(rs1.getInt("cod_producto"));
            }
            if(listaId.size() != 0)
            {
                ListIterator<Integer> li = listaId.listIterator();
                while(li.hasNext() == true)
                {
                    int id = li.next();
                    sql2 = "delete from kardex_entrada where cod_producto = "+id+"";
                    st2 = this.getCn().prepareStatement(sql2);
                    st2.executeUpdate();
                }
            }
        }
        catch(Exception err)
        {
            throw err;
        }
        
    }
    
    public int getConsecutivoNumeroFactura() throws Exception
    {
        int numeroFacturaActual = 0;
        try
        {
            this.conectar();
            String sql = "select * from consecutivo where id_consecutivo = 1";
            PreparedStatement st = this.getCn().prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if(rs.next() == true)
            {
                numeroFacturaActual = rs.getInt("actual") + 1;
            }
        }catch(Exception err)
        {
            throw err;
        }
        return numeroFacturaActual;
    }
    public List<Inventario> getListarNombresProductos(String nombreProducto) throws Exception
    {
        List<Inventario> li = new ArrayList<Inventario>();
        try
        {
            this.conectar();
            String sql = "select * from inventario  where nombre_producto like '"+nombreProducto+"%'";
            PreparedStatement st =  this.getCn().prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while(rs.next() == true)
            {
                Inventario inv = new Inventario();
                inv.setCod_producto(rs.getInt("cod_producto"));
                inv.setNombre(rs.getString("nombre_producto"));
                inv.setConcentracion(rs.getString("concentracion"));
                inv.setPresentacion(rs.getString("presentacion"));
                inv.setIva(rs.getDouble("iva"));
                inv.setCosto_unitario(rs.getDouble("costo_unitario"));
                inv.setPrecio_unitario(rs.getDouble("precio_unitario"));
                inv.setEstado(rs.getString("estado"));
                inv.setExistencias(rs.getInt("existencias"));
                li.add(inv);
            }
        }catch(Exception e)
        {
            throw e;
        }finally
        {
            this.cerrarConexion();
        }
        return li;
    }
    
    
    
    
    public String getFecha() throws Exception
    {
        String fecha = "";
        try
        {
          String sql= "select current_date";
          PreparedStatement stf  = this.getCn().prepareStatement(sql);
          ResultSet rs = stf.executeQuery();
          if(rs.next()==true)
          fecha = (String)rs.getString(1);
        }catch(Exception e)
        {
            throw e;
        }
          //--------------------------------------------------------------------
        return fecha;
    }
    public String getHora() throws Exception
    {
       
        String hora = "";
        try
        {
          String sql= "select current_time";
          PreparedStatement stf  = this.getCn().prepareStatement(sql);
          ResultSet rs = stf.executeQuery();
          if(rs.next()==true)
          hora = (String)rs.getString(1);
        }catch(Exception e)
        {
            throw e;
        }
          //--------------------------------------------------------------------
        return hora;
    } 
}
