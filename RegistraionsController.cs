using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using RegistraionForm.Models;
using System.Data.SqlClient;
using System.Configuration;
using RegistraionForm.Controllers;

namespace RegistraionForm.Controllers
{

    public class DAL
    {
        DataSet ds;
        SqlDataAdapter da;

        public static SqlConnection connect()
        {
            //Reading the connection string from web.config    
            string Name = ConfigurationManager.ConnectionStrings["StudentConnectionString"].ConnectionString;
            //Passing the string in sqlconnection.    
            SqlConnection con = new SqlConnection(Name);
            //Check wheather the connection is close or not if open close it else open it    
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            else
            {
                con.Open();
            }
            return con;

        }
        //Creating a method which accept any type of query from controller to execute and give result.    
        //result kept in datatable and send back to the controller.    
        public DataTable MyMethod(string Query)
        {
            ds = new DataSet();
            DataTable dt = new DataTable();
            da = new SqlDataAdapter(Query, DAL.connect());

            da.Fill(dt);
            List<SelectListItem> list = new List<SelectListItem>();
            return dt;
        }

    }

    public class RegistraionsController : Controller
    {
        private StudentEntities db = new StudentEntities();

        // GET: Registraions
        public ActionResult Index()
        {
            return View(db.Registraions.ToList());
        }

        // GET: Registraions/Details/5
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Registraion registraion = db.Registraions.Find(id);
            if (registraion == null)
            {
                return HttpNotFound();
            }
            return View(registraion);
        }
        DAL objdal = new DAL();
        // GET: Registraions/Create
        public ActionResult Create()
        {
            string countrystring = "select * from Country";
            DataSet ds = new DataSet();
            List<string> li = new List<string>();
            DataTable dt = new DataTable();
            dt = objdal.MyMethod(countrystring);
            List<SelectListItem> list = new List<SelectListItem>();
            //list.Add(new SelectListItem { Text = "-- Select Country --", Value = "0" });
            foreach (DataRow row in dt.Rows)
            {
                list.Add(new SelectListItem { Text = Convert.ToString(row.ItemArray[1]), Value = Convert.ToString(row.ItemArray[0]) });
            }

            ViewBag.CountryID = list;

            return View();
        }

        // POST: Registraions/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "RegistraionID,FullName,EmailID,MobileNo,Gender,Hobbies,DateOfBirth,CountryID,StateID,City")] Registraion registraion)
        {
            if (ModelState.IsValid)
            {
                db.Registraions.Add(registraion);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(registraion);
        }
        // GET: Registraions/Edit/5
        public ActionResult Edit(long? id)
        {
            string countrystring = "select C.CountryID,C.CountryName from Registraion R Inner join Country C ON C.CountryID = R.CountryID where RegistraionID =" + id + "";
            DataSet ds = new DataSet();
            List<string> li = new List<string>();
            DataTable dt = new DataTable();
            dt = objdal.MyMethod(countrystring);
            List<SelectListItem> list = new List<SelectListItem>();
            foreach (DataRow row in dt.Rows)
            {
                list.Add(new SelectListItem { Text = Convert.ToString(row.ItemArray[1]), Value = Convert.ToString(row.ItemArray[0]) });
            }
            ViewBag.CountryID = new SelectList(db.Countries, "CountryID", "CountryName");

            string Statestring = "select S.StateID,S.StateName from Registraion R Inner join State S ON S.StateID = R.StateID where RegistraionID  =" + id + "";
            DataSet StatedDS = new DataSet();
            List<string> Liststate = new List<string>();
            DataTable Statedt = new DataTable();
            Statedt = objdal.MyMethod(Statestring);
            List<SelectListItem> Statelist = new List<SelectListItem>();
            foreach (DataRow row in Statedt.Rows)
            {
                Statelist.Add(new SelectListItem { Value = Convert.ToString(row.ItemArray[0]), Text = Convert.ToString(row.ItemArray[1]) });
            }
            ViewBag.StateID = new SelectList(db.States, "StateID", "StateName");

            string Citytring = "select C.CityID,C.CityName from Registraion R Inner join City C ON C.CityID = R.City where RegistraionID  =" + id + "";
            DataSet CitydDS = new DataSet();
            List<string> Listcity = new List<string>();
            DataTable Citydt = new DataTable();
            Citydt = objdal.MyMethod(Citytring);
            List<SelectListItem> Citylist = new List<SelectListItem>();
            foreach (DataRow row in Citydt.Rows)
            {
                Citylist.Add(new SelectListItem { Value = Convert.ToString(row.ItemArray[0]), Text = Convert.ToString(row.ItemArray[1]) });
            }
            ViewBag.City = new SelectList(db.Cities, "CityID", "CityName");

            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            Registraion registraion = db.Registraions.Find(id);
            
            if (registraion == null)
            {
                return HttpNotFound();
            }
            return View(registraion);
        }

        // POST: Registraions/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "RegistraionID,FullName,EmailID,MobileNo,Gender,Hobbies,DateOfBirth,CountryID,StateID,City")] Registraion registraion)
        {
            if (ModelState.IsValid)
            {
                db.Entry(registraion).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(registraion);
        }

        // GET: Registraions/Delete/5
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Registraion registraion = db.Registraions.Find(id);
            if (registraion == null)
            {
                return HttpNotFound();
            }
            return View(registraion);
        }
        // POST: Registraions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            Registraion registraion = db.Registraions.Find(id);
            db.Registraions.Remove(registraion);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
        public JsonResult getstate(int id)
        {
            string countrystring = "select * from state where CountryID='" + id + "'";

            DataTable dt = new DataTable();
            dt = objdal.MyMethod(countrystring);
            List<SelectListItem> list = new List<SelectListItem>();
            list.Add(new SelectListItem { Text = "-- Select State --", Value = "0" });
            foreach (DataRow row in dt.Rows)
            {
                list.Add(new SelectListItem { Text = Convert.ToString(row.ItemArray[1]), Value = Convert.ToString(row.ItemArray[0]) });
            }
            return Json(new SelectList(list, "Value", "Text", JsonRequestBehavior.AllowGet));
        }
        public JsonResult getCity(int id)
        {
            string countrystring = "select * from City where StateID='" + id + "'";
            DataSet ds = new DataSet();
            List<string> li = new List<string>();
            DataTable dt = new DataTable();
            dt = objdal.MyMethod(countrystring);
            List<SelectListItem> list = new List<SelectListItem>();
            list.Add(new SelectListItem { Text = "-- Select City --", Value = "0" });
            foreach (DataRow row in dt.Rows)
            {
                list.Add(new SelectListItem { Text = Convert.ToString(row.ItemArray[1]), Value = Convert.ToString(row.ItemArray[0]) });
            }
            return Json(new SelectList(list, "Value", "Text", JsonRequestBehavior.AllowGet));
        }
    }
}

