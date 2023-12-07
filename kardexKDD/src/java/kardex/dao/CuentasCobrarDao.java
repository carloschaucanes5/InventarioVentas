/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package kardex.dao;

import java.sql.PreparedStatement;
import kardex.modelo.CuentaCobrar;

/**
 *
 * @author Carlitos
 */
public class CuentasCobrarDao extends Dao{
    
     public void registrarCuentaCobrar(CuentaCobrar cxc) throws Exception
    {
        try
        {
          this.conectar();
          String sql= "insert into cuentas_cobrar(numero_factura,cedula_cliente,estado,saldo_pendiente,detalle)values(?,?,?,?,?)";
          PreparedStatement st  = this.getCn().prepareStatement(sql);
          st.setInt(1, cxc.getNumero_factura());
          st.setString(2, cxc.getCedula_cliente());
          st.setString(3, cxc.getEstado());
          st.setDouble(4, cxc.getSaldo_pendiente());
          st.setString(5, cxc.getDetalle());
          st.executeUpdate();
          st.close();
        }catch(Exception e)
        {
           throw e;
        }finally{
           this.cerrarConexion();
        }
    }
    
    
    
}
