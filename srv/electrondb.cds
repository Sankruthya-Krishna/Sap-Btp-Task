using { com.test.taskdb as db } from '../db/schema';
service TaskService {
    entity BusinessPartner as projection on db.BusinessPartner;
    entity States as projection on db.States;
    entity Store as projection on db.Store;
    entity Product as projection on db.Product;
    entity Stock as projection on db.Stock;
    entity Purchase as projection on db.Purchase;
    entity Items as projection on db.Items;
}

annotate TaskService.BusinessPartner with @odata.draft.enabled;
annotate TaskService.States with @odata.draft.enabled;
annotate TaskService.Store with @odata.draft.enabled;
annotate TaskService.Product with @odata.draft.enabled;
annotate TaskService.Stock with @odata.draft.enabled;
annotate TaskService.Purchase with @odata.draft.enabled;
annotate TaskService.Items with @odata.draft.enabled;

annotate TaskService.BusinessPartner with {
    pincode @assert.format: '^[1-9][0-9]{5}$';
    gst_no @assert.format: '^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[0-9]{1}[Z]{1}[0-9]{1}$';
};
annotate TaskService.Store with{
    pincode @assert.format: '^[1-9][0-9]{5}$';
}
annotate TaskService.Purchase.Items with @(UI.LineItem:[
    {
        Value: item.product_id_ID  
         },
    {
        Value: item.qty_ID
    },
    {
        Value: item.price
    },
     {
        Value: item.store_id_ID
    }
],
UI.FieldGroup#PurchaseItems:{
    $Type: 'UI.FieldGroupType',
    Data:[
        {
            $Type: 'UI.DataField',
            Label: 'Store ID',
            Value: item.product_id_ID
        },
        {
            $Type: 'UI.DataField',
            Label: 'Product ID',
            Value: item.qty_ID
        },
        {
            $Type: 'UI.DataField',
            Label: 'Product Quality',
            Value: item.price
        },
        {
            $Type: 'UI.DataField',
            Label: 'Product Quality',
            Value: item.store_id_ID
        },
    ]},
    UI.Facets:[
    {
        $Type: 'UI.ReferenceFacet',
        ID: 'BusinessPFacet',
        Label: 'Product Info',
        Target: '@UI.FieldGroup#PurchaseItems'
    }
]
);
annotate TaskService.Purchase with @(UI.LineItem:[
{
    Value:order_no
},
{
    Value:BusinessPartner
},
{
    Value:order_date
},
{
    Value: Items.item.store_id_ID
},
],
UI.FieldGroup#Purchases:{
    $Type: 'UI.FieldGroupType',
    Data:[
        {
            $Type: 'UI.DataField',
            Label: 'Product ID',
            Value: order_no
        },
        {
            $Type: 'UI.DataField',
            Label: 'Quantity',
            Value: BusinessPartner
        },
        {
            $Type: 'UI.DataField',
            Label: 'Price',
            Value: order_date
        },
        {
            $Type: 'UI.DataField',
            Label: 'Store_ID',
            Value:  Items.item.qty_ID
        },
        ],},
         UI.Facets:[
    {
        $Type: 'UI.ReferenceFacet',
        ID: 'BusinessPFacet',
        Label: 'purchase Info',
        Target: '@UI.FieldGroup#Purchases'
    },
      {
            $Type : 'UI.ReferenceFacet',
            ID : 'purchaseItemFacet',
            Label : 'purchase item Information',
            Target : 'Items/@UI.LineItem',
        },
]
);
annotate TaskService.Items with @(UI.LineItem:[
{
    Value:product_id_ID
},
{
    Value:qty_ID
},
{
    Value:price
},
{
    Value:store_id_ID
}
],
UI.FieldGroup#Items:{
    $Type: 'UI.FieldGroupType',
    Data:[
        {
            $Type: 'UI.DataField',
            Label: 'Product ID',
            Value: product_id_ID
        },
        {
            $Type: 'UI.DataField',
            Label: 'Quantity',
            Value: qty_ID
        },
        {
            $Type: 'UI.DataField',
            Label: 'Price',
            Value: price
        },
        {
            $Type: 'UI.DataField',
            Label: 'Store_ID',
            Value: store_id_ID
        },
        ],},
        UI.Facets:[
    {
        $Type: 'UI.ReferenceFacet',
        ID: 'BusinessPFacet',
        Label: 'Items Info',
        Target: '@UI.FieldGroup#Items'
    }
]
        ) ;
        

annotate TaskService.Stock with @(UI.LineItem:[
    {
        Value:storeid_ID
    },
    {
        Value:productid_ID
    },
    {
        Value: stock_qty
    }
],
UI.FieldGroup#Stock:{
    $Type: 'UI.FieldGroupType',
    Data:[
        {
            $Type: 'UI.DataField',
            Label: 'Store ID',
            Value: storeid_ID
        },
        {
            $Type: 'UI.DataField',
            Label: 'Product ID',
            Value: productid_ID
        },
        {
            $Type: 'UI.DataField',
            Label: 'Product Quality',
            Value: stock_qty
        },
    ]},
    UI.Facets:[
    {
        $Type: 'UI.ReferenceFacet',
        ID: 'BusinessPFacet',
        Label: 'Product Info',
        Target: '@UI.FieldGroup#Stock'
    }
]
);

annotate TaskService.States with @(UI.LineItem:[
    {
        $Type: 'UI.DataField',
        Value: code
    },
    {
        $Type: 'UI.DataField',
        Value: description
    }
],

);
annotate TaskService.Product with @(UI.LineItem:[
    {
        Value:productid
    },
    {
        Value:productname
    },
    {
        Value:ProductImg
    },
    {
       Value: ProductCP 
    },
    {
        Value:ProductSP
    },
],
UI.FieldGroup#Products:{
    $Type: 'UI.FieldGroupType',
    Data:[
        {
            $Type: 'UI.DataField',
            Label: 'Product ID',
            Value: productid
        },
        {
            $Type: 'UI.DataField',
            Label: 'NAME',
            Value: productname
        },
        {
            $Type: 'UI.DataField',
            Label: 'Product Image',
            Value: ProductImg
        },
        {
            $Type: 'UI.DataField',
            Label: 'Cost Price',
            Value: ProductCP
        },
         {
            $Type: 'UI.DataField',
            Label: 'Selling Price',
            Value: ProductSP
        },

    ] 
},
UI.Facets:[
    {
        $Type: 'UI.ReferenceFacet',
        ID: 'BusinessPFacet',
        Label: 'Product Info',
        Target: '@UI.FieldGroup#Products'
    }
]
) ;

annotate TaskService.Store with @(UI.LineItem:[
    {
        Label:'Store_ID',
        Value: storeid
    },
    {
        Label:'NAME',
        Value:name
    },
    {
        Label: 'State',
        Value: state_code
    },
     {
            Label: 'Pincode',
            Value: pincode
        }
],
UI.FieldGroup#Stores:{
    $Type: 'UI.FieldGroupType',
    Data:[
        {
            $Type: 'UI.DataField',
            Label: 'Store Id',
            Value: storeid
        },
        {
            $Type: 'UI.DataField',
            Label: 'NAME',
            Value: name
        },
        {
            $Type: 'UI.DataField',
            Label: 'PIN CODE',
            Value: pincode
        },
        {
            $Type: 'UI.DataField',
            Label: 'State',
            Value: state_code
        },
    ] 
},
UI.Facets:[
    {
        $Type: 'UI.ReferenceFacet',
        ID: 'BusinessPFacet',
        Label: 'Store Info',
        Target: '@UI.FieldGroup#Stores'
    }
]
) ;


annotate TaskService.BusinessPartner with @(UI.LineItem:[
    {
        Label: 'Business Partner Id',
        Value: bp_no
    },
    {
        Label: 'Name',
        Value: name
    },
    {
        Label: 'State',
        Value: state_code
    },
     {
            Label: 'Pincode',
            Value: pincode
        },
    {
        Label: 'Is GSTN Registered',
        Value: gst_registered
    },
    {
        Label: 'GSTIN Number',
        Value: gst_no
    }
],
UI.FieldGroup#Business:{
    $Type: 'UI.FieldGroupType',
    Data:[
        {
            $Type: 'UI.DataField',
            Label: 'Business Partner Id',
            Value: bp_no
        },
        {
            $Type: 'UI.DataField',
            Label: 'Name',
            Value: name
        },
        {
            $Type: 'UI.DataField',
            Label: 'Pincode',
            Value: pincode
        },
        {
            $Type: 'UI.DataField',
            Label: 'State',
            Value: state_code
        },
        {
            $Type: 'UI.DataField',
            Label: 'Is GSTN Registered',
            Value: gst_registered
        },
        {
            $Type: 'UI.DataField',
            Label: 'GSTIN Number',
            Value: gst_no
        }
    ]
},
UI.Facets:[
    {
        $Type: 'UI.ReferenceFacet',
        ID: 'BusinessPFacet',
        Label: 'Business Partner Info',
        Target: '@UI.FieldGroup#Business'
    }
]);

annotate TaskService.BusinessPartner with {
    state @(
        Common.ValueListWithFixedValues: true,
        Common.ValueList: {
            Label: 'State',
            CollectionPath: 'States',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'state_code',
                    ValueListProperty: 'code'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'description'
                }
            ]
        }
    )
};
annotate TaskService.Store with {
    state @(
        Common.ValueListWithFixedValues: true,
        Common.ValueList: {
            Label: 'State',
            CollectionPath: 'States',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'state_code',
                    ValueListProperty: 'code'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'description'
                }
            ]
        }
    )
};
annotate TaskService.Stock with{
    storeid @(
        Common.Text:storeid.storeid,
        Common.TextArrangement:#TextOnly,
         Common.ValueListWithFixedValues: true,
        Common.ValueList: {
            Label: 'Storeid',
            CollectionPath: 'Store',
            Parameters:[
                 {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'storeid_ID',
                    ValueListProperty: 'ID'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        }
    )
}
annotate TaskService.Stock with{
    productid @(
        Common.Text:productid.productid,
        Common.TextArrangement:#TextOnly,
         Common.ValueListWithFixedValues: true,
        Common.ValueList: {
            Label: 'Productid',
            CollectionPath: 'Product',
            Parameters:[
                 {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'productid_ID',
                    ValueListProperty: 'ID'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'productname'
                }
            ]
        }
    )
}
annotate TaskService.Items with {
   product_id @(
     Common.Text:product_id.productid,
        Common.TextArrangement:#TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList: {
            Label: 'Products',
            CollectionPath: 'Product',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'product_id_ID',
                    ValueListProperty: 'ID'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'productname'
                }
            ]
        }
    )
}
annotate TaskService.Items with{
    qty @(
       Common.Text:qty.stock_qty,
        Common.TextArrangement:#TextOnly,
         Common.ValueListWithFixedValues: true,
        Common.ValueList: {
            Label: 'Quantity',
            CollectionPath: 'Stock',
            Parameters:[
                 {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'qty_ID',
                    ValueListProperty: 'ID'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'stock_qty'
                }
            ]
        }
    )
}
annotate TaskService.Items with{
   store_id @(
       Common.Text:store_id.storeid,
        Common.TextArrangement:#TextOnly,
         Common.ValueListWithFixedValues: true,
        Common.ValueList: {
            Label: 'Store',
            CollectionPath: 'Store',
            Parameters:[
                 {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'store_id_ID',
                    ValueListProperty: 'ID'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        }
    )
}
annotate  TaskService.Purchase.Items with{
   item @(
       Common.Text:item.product_id.productid,
        Common.TextArrangement:#TextOnly,
         Common.ValueListWithFixedValues: true,
        Common.ValueList: {
            Label: 'product',
            CollectionPath: 'Product',
            Parameters:[
                 {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'item_ID',
                    ValueListProperty: 'ID'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'productid'
                }
            ]
        },)
}
