using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RegistraionForm : System.Web.UI.Page
{
    DataClassesDataContext linqobj = new DataClassesDataContext();
    static string image;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
            return;
        fillcountry();
        fillregistraion();
    }
    private void fillregistraion()
    {
        if (txtsearch.Text != "" )
        {
            var id = (from a in linqobj.Registraions
                      join b in linqobj.countries on a.country equals b.countryid
                      join c in linqobj.states on a.state equals c.stateid
                      where a.firstname.Contains(txtsearch.Text) || a.lastname.Contains(txtsearch.Text)
                      select new
                      {
                          code = a.RegistraionID,
                          firstname = a.firstname,
                          lastname = a.lastname,
                          emailid = a.emailid,
                          mobileno = a.mobileno,
                          gender = a.gender,
                          country = b.countryname,
                          state = c.statename,
                          hobbies = a.hobbies,
                          images = "./upload/" + a.images
                      }).ToList();
            gridview.DataSource = id;
            gridview.DataBind();

            if (id.Count == 0)
            {
                tblregistraion.Visible = false;
            }
            else
            {
                tblregistraion.Visible = true;
            }
        }
        else
        {
            var id = (from a in linqobj.Registraions
                      join b in linqobj.countries on a.country equals b.countryid
                      join c in linqobj.states on a.state equals c.stateid
                      select new
                      {
                          code = a.RegistraionID,
                          firstname = a.firstname,
                          lastname = a.lastname,
                          emailid = a.emailid,
                          mobileno = a.mobileno,
                          gender = a.gender,
                          country = b.countryname,
                          state = c.statename,
                          hobbies = a.hobbies,
                          images = "./upload/" + a.images
                      }).ToList();
            gridview.DataSource = id;
            gridview.DataBind();

            if (id.Count == 0)
            {
                tblregistraion.Visible = false;
            }
            else
            {
                tblregistraion.Visible = true;
            }
        }
    }
    private void fillcountry()
    {
        var id = (from a in linqobj.countries
                  select a).ToList();
        ddlcountry.DataSource = id;
        ddlcountry.DataBind();
        ddlcountry.Items.Insert(0, "-- Select Country --");
    }
    private void fillstate()
    {
        var id = (from a in linqobj.states
                  select a).ToList();
        ddlstate.DataSource = id;
        ddlstate.DataBind();
        ddlstate.Items.Insert(0, "-- Select State --");
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        if (fuimage.PostedFile.FileName != "")
        {
            fuimage.SaveAs(Request.PhysicalApplicationPath + "./upload/" + fuimage.FileName);
            image = fuimage.FileName;
        }
        string hobbies = "";
        for (int i = 0; i < chkhobbies.Items.Count; i++)
        {
            if (chkhobbies.Items[i].Selected)
            {
                if (hobbies == "")
                {
                    hobbies = chkhobbies.Items[i].Value;
                }
                else
                {
                    hobbies += "," + chkhobbies.Items[i].Value;
                }
            }
        }
        linqobj.insertregistraion(txtfirstname.Text, txtlastname.Text, txtemailid.Text, txtmobileno.Text, RBList.SelectedItem.Text,
                                  Convert.ToInt32(ddlcountry.SelectedValue), Convert.ToInt32(ddlstate.SelectedValue), hobbies, image);
        linqobj.SubmitChanges();
        fillregistraion();
        ClientScript.RegisterStartupScript(this.GetType(), "Success", "<script type='text/javascript'>alert('** Thanks For Registration **');window.location='RegistraionForm.aspx';</script>'");
    }
    protected void ddlcountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        fillstate();
    }
    protected void gridview_RowEditing(object sender, GridViewEditEventArgs e)
    {
        int code = Convert.ToInt32(gridview.DataKeys[e.NewEditIndex].Value.ToString());
        ViewState["code"] = code;
        var id = (from a in linqobj.Registraions
                  where a.RegistraionID == code
                  select a).Single();

        txtfirstname.Text = id.firstname;
        txtlastname.Text = id.lastname;
        txtemailid.Text = id.emailid;
        txtmobileno.Text = id.mobileno;
        RBList.SelectedValue = id.gender;
        ddlcountry.SelectedValue = id.country.ToString();
        ddlstate.SelectedValue = id.state.ToString();
        fillstate();
        image = id.images;

        string[] abc = id.hobbies.Split(',');
        for (int i = 0; i < abc.Length; i++)
        {
            string xyz = abc[i].ToString();
            for (int j = 0; j < chkhobbies.Items.Count; j++)
            {
                if (chkhobbies.Items[j].Value == xyz)
                {
                    chkhobbies.Items[j].Selected = true;
                }
            }
        }

        btnsubmit.Visible = false;
        btnupdate.Visible = true;
    }
    protected void gridview_RowDeletinsg(object sender, GridViewDeleteEventArgs e)
    {
        linqobj.deleteregistraion(Convert.ToInt32(gridview.DataKeys[e.RowIndex].Value.ToString()));
        linqobj.SubmitChanges();
        fillregistraion();
        Page.RegisterStartupScript("onload", "<script language='javascript'>alert('** Delete Successfully **')</script>");
    }
    protected void gridview_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridview.PageIndex = e.NewPageIndex;
        fillregistraion();
    }
    protected void btnupdate_Click(object sender, EventArgs e)
    {
        string hobbies = "";
        for (int i = 0; i < chkhobbies.Items.Count; i++)
        {
            if (chkhobbies.Items[i].Selected)
            {
                if (hobbies == "")
                {
                    hobbies = chkhobbies.Items[i].Value;
                }
                else
                {
                    hobbies += "," + chkhobbies.Items[i].Value;
                }
            }
        }

        if(fuimage.PostedFile.FileName != "")
        {
            fuimage.SaveAs(Request.PhysicalApplicationPath + "/upload/" + fuimage.FileName);
            image = fuimage.FileName;
        }

        linqobj.updateregistraion(Convert.ToInt32(ViewState["code"].ToString()),txtfirstname.Text,txtlastname.Text,txtemailid.Text,txtmobileno.Text,RBList.SelectedItem.Text,
                                  Convert.ToInt32(ddlcountry.SelectedValue),Convert.ToInt32(ddlstate.SelectedValue),hobbies,image);
        linqobj.SubmitChanges();
        fillregistraion();
        ClientScript.RegisterStartupScript(this.GetType(), "Success", "<script type='text/javascript'>alert('** Update Successfully **');window.location='RegistraionForm.aspx';</script>'");
    }
    protected void btncancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("RegistraionForm.aspx");
    }
    protected void btnsearch_Click(object sender, EventArgs e)
    {
        fillregistraion();
    }
}