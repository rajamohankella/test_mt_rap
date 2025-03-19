CLASS zcl_mt_rk_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    INTERFACES if_amdp_marker_hdb .

    class-METHODS: add_numbers
                        IMPORTING
                          VALUE(x) TYPE i
                          VALUE(y) TYPE i
                        EXPORTING
                          VALUE(res) TYPE i.

    CLASS-METHODS: get_customer_by_id
                      IMPORTING
                        VALUE(i_bp_id) TYPE zmt_rk_dte_id
                      EXPORTING
                        VALUE(e_res) TYPE char40.

   CLASS-METHODS get_product_mrp IMPORTING
                                   VALUE(i_tax) type i
                                 EXPORTING
                                   VALUE(otab) type ZMT_rk_TT_PRODUCT_MRP.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mt_rk_amdp IMPLEMENTATION.

  METHOD add_numbers BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY.
    res := :x + :y;
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

    zcl_mt_rk_amdp=>get_product_mrp(
      EXPORTING
        i_tax = 12
      IMPORTING
        otab = DATA(itab)
      ).


*   zcl_mt_ab_amdp=>add_numbers(
*     EXPORTING
*       x   = 25
*       y   = 30
*     IMPORTING
*       res = data(result)
*   ).

*   zcl_mt_ab_amdp=>get_customer_by_id(
*     EXPORTING
*       i_bp_id = 'CE0AC213BE7A1EDFBFC53B0E7AD65E6C'
*     IMPORTING
*       e_res   = data(result)
*   ).


   out->write(
    EXPORTING
       data   = itab
*        name   =
*      RECEIVING
*        output =
   ).
 ENDMETHOD.

  METHOD get_customer_by_id BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING zmt_ab_bpa.
    SELECT company_name INTO e_res FROM zmt_ab_bpa WHERE bp_id = :i_bp_id;
  ENDMETHOD.


  METHOD get_product_mrp BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
                           options read-only
                           USING zmt_rk_product.
*   declare variables
   declare lv_Count integer;
   declare i integer;
   declare lv_mrp bigint;
   declare lv_price_d integer;

*   get all the products in a implicit table (like a internal table in abap)
   lt_prod = select * from zmt_rk_product;

*   get the record count of the table records
   lv_count := record_count( :lt_prod );

*   loop at each record one by one and calculate the price after discount (dbtable)
   for i in 1..:lv_count do
*   calculate the MRP based on input tax
       lv_price_d := :lt_prod.price[i] * ( 100 - :lt_prod.discount[i] ) / 100;
       lv_mrp := :lv_price_d * ( 100 + :i_tax ) / 100;
*   if the MRP is more than 15k, an additional 10% discount to be applied
       if lv_mrp > 15000 then
           lv_mrp := :lv_mrp * 0.90;
       END IF ;
*   fill the otab for result (like in abap we fill another internal table with data)
       :otab.insert( (
                         :lt_prod.name[i],
                         :lt_prod.category[i],
                         :lt_prod.price[i],
                         :lt_prod.currency[i],
                         :lt_prod.discount[i],
                         :lv_price_d,
                         :lv_mrp
                     ), i );
   END FOR ;
 ENDMETHOD.



ENDCLASS.
