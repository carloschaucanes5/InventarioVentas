/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package kardex.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import kardex.modelo.Empleado;

/**
 *
 * @author Carlitos
 */
public class EmpleadoDao extends Dao{
    
    
    public  Empleado getEmpleadoPorCedula(String cedula ,String contrasenia) throws Exception
    {
       Empleado em = null;
        try
        {
            this.conectar();
            String sql = "select * from empleado  where cedula_empleado='"+cedula+"' and clave_acceso = '"+contrasenia+"'";
            PreparedStatement st =  this.getCn().prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if(rs.next() == true)
            {
                em = new Empleado();
                em.setCedula_empleado(rs.getString("cedula_empleado"));
                em.setNombre(rs.getString("nombre"));
                em.setClave_acceso(rs.getString("clave_acceso"));
                return em;
            }
        }catch(Exception e)
        {
            throw e;
        }            
       return em; 
    }
}
