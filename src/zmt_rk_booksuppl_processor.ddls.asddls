@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking supplement projection'
@Metadata.ignorePropagatedAnnotations: false
@Metadata.allowExtensions: true
define view entity ZMT_RK_BOOKSUPPL_PROCESSOR as projection on zmt_rk_booksuppl
{
    key TravelId,
    key BookingId,
    key BookingSupplementId,
    SupplementId,
    Price,
    CurrencyCode,
    LastChangedAt,
    /* Associations */
    _Booking: redirected to parent ZMT_RK_BOOKING_PROCESSOR,
    _Product,
    _SupplementText,
    _Travel: redirected to ZMT_RK_TRAVEL_PROCESSOR
}
