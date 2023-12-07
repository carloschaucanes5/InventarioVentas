/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package kardex.dao;

import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import kardex.modelo.Inventario;


/**
 *
 * @author Carlitos
 */
public class InventarioDao extends Dao{
    
    public void registrarInventario(Inventario inventario) throws Exception
    {
        try
        {
            
          this.conectar();
          this.getCn().setAutoCommit(false);
          String sql=""+
           "insert into inventario"+
           "(nombre_producto,concentracion,presentacion,"+
           "iva,costo_unitario,precio_unitario,estado,existencias)"+
           "values(?,?,?,?,?,?,?,?)";
          PreparedStatement st  = this.getCn().prepareStatement(sql);
          st.setString(1, inventario.getNombre());
          st.setString(2, inventario.getConcentracion());
          st.setString(3, inventario.getPresentacion());
          /*st.setString(4, inventario.getProveedor().getNit_proveedor());
          st.setInt(5, inventario.getLaboratorio().getCod_laboratorio());*/
          st.setDouble(4, inventario.getIva());
          st.setDouble(5, inventario.getCosto_unitario());
          st.setDouble(6, inventario.getPrecio_unitario());
          st.setString(7, "A");
          st.setInt(8, 0);
          st.executeUpdate();
          st.close();
          System.out.println("Registro almacenado con exito");
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
    
    
    /**/
    
   
    
    public static void main(String arg[]) 
    {
        /*
        try
        {
        Proveedor proveedor = new Proveedor();
        proveedor.setNit_proveedor("1086498977");
        proveedor.setNombre_proveedor("karlosKDDUdenar");
        proveedor.setDireccion("calle 13 no 20-40");
        proveedor.setCiudad("Pasto");
        proveedor.setReguimen("Común");
        
        Laboratorio laboratorio = new Laboratorio();
        laboratorio.setCod_laboratorio(1);
        laboratorio.setNombre_laboratorio("QuimicasKDD");
        
        Inventario inventario = new Inventario();
        inventario.setNombre("acetaminofen");
        inventario.setConcentracion("15mg");
        inventario.setPresentacion("capsulas");
        inventario.setProveedor(proveedor);
        inventario.setLaboratorio(laboratorio);
        inventario.setIva(16);
        inventario.setCosto_unitario(2300.6);
        inventario.setPrecio_unitario(4000);
        
        InventarioDao dao = new InventarioDao();
        dao.conectar();
        dao.registrarInventario(inventario);
        }catch(Exception e)
        {
            System.out.println("error:"+e);
        }*/
    }
}
