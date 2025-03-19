@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Attachment Processor'
@Metadata.ignorePropagatedAnnotations: false
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zmt_rk_m_attach_processor as projection on zmt_rk_m_attach
{
    key TravelId,
    key Id,
    Memo,
    @Semantics.largeObject: {
       mimeType: 'Filetype',
       fileName: 'Filename',
       contentDispositionPreference: #INLINE,
       acceptableMimeTypes: [ 'application/pdf' ]
    }
    Attachment,
   Filename,
   @Semantics.mimeType: true
   Filetype,
   LocalCreatedBy,
   LocalCreatedAt,
   LocalLastChangedBy,
   LocalLastChangedAt,
   LastChangedAt,
   /* Associations */
   _Travel: redirected to parent ZMT_RK_TRAVEL_PROCESSOR
}
