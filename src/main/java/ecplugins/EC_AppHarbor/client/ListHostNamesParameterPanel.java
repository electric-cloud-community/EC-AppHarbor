
// ListHostNamesParameterPanel.java --
//
// ListHostNamesParameterPanel.java is part of ElectricCommander.
//
// Copyright (c) 2005-2012 Electric Cloud, Inc.
// All rights reserved.
//

package ecplugins.EC_AppHarbor.client;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import com.google.gwt.core.client.GWT;
import com.google.gwt.event.logical.shared.ValueChangeEvent;
import com.google.gwt.event.logical.shared.ValueChangeHandler;
import com.google.gwt.uibinder.client.UiBinder;
import com.google.gwt.uibinder.client.UiFactory;
import com.google.gwt.uibinder.client.UiField;
import com.google.gwt.user.client.ui.TextBox;
import com.google.gwt.user.client.ui.Widget;

import com.electriccloud.commander.client.domain.ActualParameter;
import com.electriccloud.commander.client.domain.FormalParameter;
import com.electriccloud.commander.client.util.StringUtil;
import com.electriccloud.commander.gwt.client.ComponentBase;
import com.electriccloud.commander.gwt.client.ui.FormBuilder;
import com.electriccloud.commander.gwt.client.ui.ParameterPanel;
import com.electriccloud.commander.gwt.client.ui.ParameterPanelProvider;
import com.electriccloud.commander.gwt.client.ui.ValuedListBox;

/**
 * Basic component that is meant to be cloned and then customized to perform a
 * real function.
 */
public class ListHostNamesParameterPanel
    extends ComponentBase
    implements ParameterPanel,
        ParameterPanelProvider
{

    //~ Static fields/initializers ---------------------------------------------

    // ~ Static fields/initializers----------------------------
    private static UiBinder<Widget, ListHostNamesParameterPanel> s_binder = GWT
            .create(Binder.class);

    // These are all the formalParameters on the Procedure
    static final String CONFIGNAME = "ConfigName";
    static final String ACTION     = "Action";
    static final String APPSLUG    = "AppSlug";
    static final String HOSTNAME   = "Hostname";

    //~ Instance fields --------------------------------------------------------

    // ~ Instance fields
    // --------------------------------------------------------
    @UiField FormBuilder LHNParameterForm;

    //~ Methods ----------------------------------------------------------------

    /**
     * This function is called by SDK infrastructure to initialize the UI parts
     * of this component.
     *
     * @return  A widget that the infrastructure should place in the UI; usually
     *          a panel.
     */
    @Override public Widget doInit()
    {
        Widget              base   = s_binder.createAndBindUi(this);
        final ValuedListBox Action = getUIFactory().createValuedListBox();

        Action.addItem("List Hostnames", "list");
        Action.addItem("Get Hostname Detail", "get");
        LHNParameterForm.addRow(true, "Configuration:",
            "The name of the configuration that contains the information to connect with AppHarbor.",
            CONFIGNAME, "", new TextBox());
        LHNParameterForm.addRow(true, "Action:",
            "Select the Action to perform, the options are: List Hostnames and Get Hostname Detail.",
            ACTION, "list", Action);
        LHNParameterForm.addRow(true, "Application Slug:",
            "The globally unique, URL-friendly version of the application name.",
            APPSLUG, "", new TextBox());
        LHNParameterForm.addRow(false, "Host Name:", "The Hostname identifier.",
            HOSTNAME, "", new TextBox());
        Action.addValueChangeHandler(new ValueChangeHandler<String>() {
                @Override public void onValueChange(
                        ValueChangeEvent<String> event)
                {
                    updateRowVisibility();
                }
            });
        updateRowVisibility();

        return base;
    }

    /**
     * Performs validation of user supplied data before submitting the form.
     *
     * <p>This function is called after the user hits submit.</p>
     *
     * @return  true if checks succeed, false otherwise
     */
    @Override public boolean validate()
    {
        boolean validationStatus = LHNParameterForm.validate();
        String  action           = LHNParameterForm.getValue(ACTION);

        if (StringUtil.isEmpty(LHNParameterForm.getValue(CONFIGNAME))) {
            LHNParameterForm.setErrorMessage(CONFIGNAME,
                "This Field is required.");
            validationStatus = false;
        }

        if (StringUtil.isEmpty(LHNParameterForm.getValue(ACTION)
                                               .trim())) {
            LHNParameterForm.setErrorMessage(ACTION, "This Field is required.");
            validationStatus = false;
        }

        if (StringUtil.isEmpty(LHNParameterForm.getValue(APPSLUG)
                                               .trim())) {
            LHNParameterForm.setErrorMessage(APPSLUG,
                "This Field is required.");
            validationStatus = false;
        }

        if ((action.equals("get"))
                && (StringUtil.isEmpty(
                        LHNParameterForm.getValue(HOSTNAME)
                                    .trim()))) {
            LHNParameterForm.setErrorMessage(HOSTNAME,
                "This Field is required.");
            validationStatus = false;
        }

        return validationStatus;
    }

    /**
     * This method is used by UIBinder to embed FormBuilder's in the UI.
     *
     * @return  a new FormBuilder.
     */
    @UiFactory FormBuilder createFormBuilder()
    {
        return getUIFactory().createFormBuilder();
    }

    private void updateRowVisibility()
    {
        String action = LHNParameterForm.getValue(ACTION);

        LHNParameterForm.setRowVisible(HOSTNAME, "get".equals(action));
    }

    /**
     * Straight forward function usually just return this;
     *
     * @return  straight forward function usually just return this;
     */
    @Override public ParameterPanel getParameterPanel()
    {
        return this;
    }

    /**
     * Gets the values of the parameters that should map 1-to-1 to the formal
     * parameters on the object being called. Transform user input into a map of
     * parameter names and values.
     *
     * <p>This function is called after the user hits submit and validation has
     * succeeded.</p>
     *
     * @return  The values of the parameters that should map 1-to-1 to the
     *          formal parameters on the object being called.
     */
    @Override public Map<String, String> getValues()
    {
        Map<String, String> actualParams     = new HashMap<String, String>();
        Map<String, String> searchFormValues = LHNParameterForm.getValues();

        actualParams.put(CONFIGNAME, searchFormValues.get(CONFIGNAME));
        actualParams.put(ACTION, searchFormValues.get(ACTION));
        actualParams.put(APPSLUG, searchFormValues.get(APPSLUG));
        actualParams.put(HOSTNAME, searchFormValues.get(HOSTNAME));

        return actualParams;
    }

    /**
     * Push actual parameters into the panel implementation.
     *
     * <p>This is used when editing an existing object to show existing content.
     * </p>
     *
     * @param  actualParameters  Actual parameters assigned to this list of
     *                           parameters.
     */
    @Override public void setActualParameters(
            Collection<ActualParameter> actualParameters)
    {

        // Store actual params into a hash for easy retrieval later
        if (actualParameters == null) {
            return;
        }

        // First load the parameters into a map. Makes it easier to
        // update the form by querying for various params randomly.
        Map<String, String> params = new HashMap<String, String>();

        for (ActualParameter p : actualParameters) {
            params.put(p.getName(), p.getValue());
        }

        // Do the easy form elements first.
        for (String key : new String[] {CONFIGNAME, ACTION, APPSLUG, HOSTNAME}) {
            LHNParameterForm.setValue(key,
                StringUtil.nullToEmpty(params.get(key)));
        }
    }

    /**
     * Push form parameters into the panel implementation.
     *
     * <p>This is used when creating a new object and showing default values.
     * </p>
     *
     * @param  formalParameters  Formal parameters on the target object.
     */
    @Override public void setFormalParameters(
            Collection<FormalParameter> formalParameters) { }

    //~ Inner Interfaces -------------------------------------------------------

    interface Binder
        extends UiBinder<Widget, ListHostNamesParameterPanel> { }
}
