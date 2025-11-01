using CadParcial2Edmd;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClnParcial2Edmd
{
    public class CanalCln
    {
        public static int insertar(Canal canal)
        {
            using (var context = new Parcial2EdmdEntities())
            {
                context.Canal.Add(canal);
                context.SaveChanges();
                return canal.id;
            }
        }
        public static int actualizar(Canal canal)
        {
            using (var context = new Parcial2EdmdEntities())
            {
                var existe = context.Canal.Find(canal.id);
                existe.nombre = canal.nombre;
                existe.frecuencia = canal.frecuencia;
                existe.estado = canal.estado;
                return context.SaveChanges();
            }
        }

        public static int eliminar(int id)
        {
            using (var context = new Parcial2EdmdEntities())
            {
                var existe = context.Canal.Find(id);
                existe.estado = -1;
                return context.SaveChanges();
            }
        }
        public static Canal obtenerUno(int id)
        {
            using (var context = new Parcial2EdmdEntities())
            {
                return context.Canal.Find(id);
            }
        }
        public static List<Canal> listar()
        {
            using (var context = new Parcial2EdmdEntities())
            {
                return context.Canal.Where(x => x.estado != -1).ToList();
            }
        }

        public static List<paCanalListar_Result> listarPa(string parametro)
        {
            using (var context = new Parcial2EdmdEntities())
            {
                return context.paCanalListar(parametro).ToList();
            }
        }
    }
}
