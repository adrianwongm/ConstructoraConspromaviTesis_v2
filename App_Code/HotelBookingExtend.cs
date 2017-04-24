using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using DevExpress.Internal;

namespace HotelBooking {
    public class HotelBookingDataContextExt : HotelBookingDataContext {
        static string ConnectionString {
            get {
                string sqlExpressString = ConfigurationManager.ConnectionStrings["HotelBookingConnectionString"].ConnectionString;
                return DbEngineDetector.PatchConnectionString(sqlExpressString);
            }
        }
        //Linea para entorno de publicacion
        //public HotelBookingDataContextExt() :base(ConnectionString.Replace("(local)", "SQL5033.SmarterASP.NET")) { }

        //Linea para entorno de desarrollo
         ///  public HotelBookingDataContextExt() : base(ConnectionString.Replace(@"(localdb)\mssqllocaldb", "SQL5033.SmarterASP.NET")) { }
        //Linea para entorno de publicacion
        public HotelBookingDataContextExt() :base(ConnectionString.Replace("(local)", "SQL5033.SmarterASP.NET")) { }

        //Linea para entorno de desarrollo interno
        //public HotelBookingDataContextExt() : base(ConnectionString.Replace(@"(localdb)\mssqllocaldb", "9.0.1.223")) { }
    }

    public partial class City {
        public string DisplayName {
            get {
                if(string.IsNullOrEmpty(State_Province))
                    return string.Format("{0}, {1}", City_Name, Country);
                else
                    return string.Format("{0}, {1}, {2}", City_Name, State_Province, Country);
            }
        }
        public Hotel CheapestHotel {
            get {
                return Hotels.Aggregate((h1, h2) => {
                    return h1.StartPrice < h2.StartPrice ? h1 : h2;
                });
            }
        }
        public string City_Image_Url {
            get { return string.Format("~/Content/Cities/{0}", City_Image).Replace(".png", ".jpg"); }
        }
    }

    public partial class Hotel {
        public decimal StartPrice {
            get {
                try
                {

                    return Rooms.Min(r => r.Nighly_Rate).Value;
                }
                catch (Exception)
                {
                    return 0;
                }
            }
        }
        public decimal EndPrice {
            get {
                try
                {
                    return Rooms.Max(r => r.Nighly_Rate).Value;
                }
                catch (Exception)
                {
                    return 0;
                }
                
            }
        }
        public string DetailsCity {
            get {
                if(!string.IsNullOrEmpty(City.State_Province))
                    return string.Format("{0}, {1} {2}, {3}", City.City_Name, City.State_Province, Postal_Code, City.Country);
                return string.Format("{0} {1}, {2}", City.City_Name, Postal_Code, City.Country);
            }
        }
        public Picture PrimaryPicture {
            get { 
                if(Pictures.Any())
                    return Pictures[0];
                return new Picture();
            }
        }
        public Picture SecondaryPicture {
            get {
                if(Pictures.Count > 1)
                    return Pictures[1];
                return new Picture();
            }
        }
        public int RoundRating {
            get {
                return (int)Math.Round(Customer_Rating);
            }
        }
        public decimal Customer_Rating {
            get { 
                return DataProvider.CustomRatings.ContainsKey(ID) ? DataProvider.CustomRatings[ID] : Convert.ToDecimal(Avg_Customer_Rating.Value); 
            }
        }

        public List<SP_SCPV_ObtenerListadoImagenResult> obtenerListadoImagenesHoteles(int ID)
        {
            HotelBookingDataContext context = new HotelBookingDataContext();
            var a = (from p in context.SP_SCPV_ObtenerListadoImagen(ID) select p).ToList();
            return a;
        }

        public bool GrabarImagenes(Picture pImagen) {
            bool bandera = false;
            try
            { 
                HotelBookingDataContext context = new HotelBookingDataContext();
                context.Pictures.InsertOnSubmit(pImagen);
                context.SubmitChanges();
                bandera = true;
            }
            catch (Exception)
            { 
                throw;
            }
            return bandera;
        }

        public bool EliminarImagenes(int pID_Imagen) {
            bool bandera = false;
            try
            {
                HotelBookingDataContext context = new HotelBookingDataContext();
                var pImagen = context.Pictures.Where(p => p.ID == pID_Imagen).FirstOrDefault();
                context.Pictures.DeleteOnSubmit(pImagen);
                context.SubmitChanges();
                bandera = true;
            }
            catch (Exception)
            {
                throw;
            }
            return bandera;
        }
    }

    public partial class Picture {
        public string Url {
            get { 
                if(!string.IsNullOrEmpty(Picture_Id))
                    return "~/Content/Pictures/" + Picture_Id;
                return "~/Content/Images/no-image.png";
            }
        }
    }

    public partial class Room_Feature {
        public string ImageUrl {
            get { return string.Format("~/Content/RoomFeatures/{0}", Feature_Image); }
        }
    }

    public partial class Room {
        public DateTime PriceAvailableDate {
            get { return DateTime.Now; }
        }
    }




    public partial class Metro_Area {
        public string Map_ImageUrl {
            get {
                return string.Format("~/Content/Maps/{0}", Map_Image);
            }
        }
        public int Hotels_Count {
            get {
                return Cities.SelectMany(c => c.Hotels).Count();
            }
        }

        public decimal MinRoomPrice {
            get {
                return Cities.SelectMany(c => c.Hotels).SelectMany(h => h.Rooms).Min(r => r.Nighly_Rate).Value;
            }
        }
        public decimal MaxRoomPrice {
            get {
                return Cities.SelectMany(c => c.Hotels).SelectMany(h => h.Rooms).Max(r => r.Nighly_Rate).Value;
            }
        }
    }

    public partial class SCPV_Usuario_Empleados
    {
        public SCPV_Empleados Empleado { get; set; }
        public string Empleado_Nombres { get; set; }
    }

    public partial class SCPV_Cargo
    {

    }

    public partial class SCPV_Empresa
    {
        public override string ToString()
        {
            return this.Ruc_Empresa + "-" + this.Nombre_Empresa;
        }
    }

    public partial class SCPV_Empleados
    {
        public string Empleado_Nombres
        {
            get
            {
                return this.NumeroIdentificacion + " - " + this.Apellidos + " " + this.Nombres;
            }
        }

        public override string ToString()
        {
            return this.NumeroIdentificacion + " - " + this.Apellidos + " " + this.Nombres;
        }
    }
}
