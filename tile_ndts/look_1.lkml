# include: "/views/order_items.view"
# view: tile_1_ndt {
#   derived_table: {
#     explore_source: order_items {
#       column: brand {field:products.brand}
#       column: count {field:products.count}
#       column: gender {field:users.gender}
#     }
#
#   }
#   dimension: brand {hidden:yes}
#   dimension: gender {hidden:yes}
#   measure: count {hidden: yes
#     type: sum
#     sql: ${TABLE}.count ;;
#   }
# }
#
# view: tile_1_ndt_order_items {
# #   extends: [order_items]
#   set: ndt_fields {fields:[]}
# }
#
#
# # include: "/views/products.view"
# view: tile_1_ndt_products {
# #   extends: [products]
#   dimension: brand {
#     sql: ${tile_1_ndt.brand} ;;
#   }
#   measure: count {
#     type: number
#     sql: ${tile_1_ndt.count} ;;
#   }
#   set: ndt_fields {fields:[brand,count]}
# }
#
# # include: "/views/users.view"
# view: tile_1_ndt_users {
# #   extends: [users]
#   dimension: gender {
#     sql: ${tile_1_ndt.gender} ;;
#   }
#   set: ndt_fields {fields:[gender]}
# }
#
# explore: tile_1_ndt {
#   join: order_items {
#     from: tile_1_ndt_order_items
#     fields: [ndt_fields*]
#     sql: ;;
#     relationship: one_to_one
#   }
#   join: products {
#     from: tile_1_ndt_products
#     fields: [ndt_fields*]
#     sql: ;;
#     relationship: one_to_one
#   }
#   join: users {
#     from: tile_1_ndt_users
#     fields: [ndt_fields*]
#     sql: ;;
#   relationship: one_to_one
#   }
# }





##### autogenerated
view: tile_1_ndt {
  derived_table: {
    explore_source: order_items {
      column: products_category {field:products.category}
      column: users_gender {field:users.gender}
      column: order_items_average_sale_price {field:order_items.average_sale_price}
      column: users_count {field:users.count}
    }
  }
  dimension: products_category {hidden:yes type:string label:"Category"}
  dimension: users_gender {hidden:yes type:string label:"Gender"}
  measure: order_items_average_sale_price {hidden:yes type:average sql:${TABLE}.order_items_average_sale_price;;}
  measure: users_count {hidden:yes type:sum sql:${TABLE}.users_count;;}
}


view: tile_1_ndt_products {
  dimension: category {
    type:string
    sql: ${tile_1_ndt.products_category};;

  }}

view: tile_1_ndt_users {
  dimension: gender {
    type:string
    sql: ${tile_1_ndt.users_gender};;
#     skip_drill_filter: yes
    html: <a href="https://profservices.dev.looker.com{{link | replace: _explore._name,'base_explore'}}">{{rendered_value}}</a>;;
  }
  measure: count{ type: number label:"Count"
    sql: ${tile_1_ndt.users_count};;
  }
}


view: tile_1_ndt_order_items {
  measure: average_sale_price{ type: number label:"Average Sale Price"
    sql: ${tile_1_ndt.order_items_average_sale_price};;
  } }

explore: tile_1_ndt {

  join: products {from: tile_1_ndt_products sql:;; relationship: one_to_one}
join: users {from: tile_1_ndt_users sql:;; relationship: one_to_one}
join: order_items {from: tile_1_ndt_order_items sql:;; relationship: one_to_one}
}



######
    view: tile_2_ndt {
      derived_table: {
        explore_source: order_items {
          column: inventory_items_product_name {field:inventory_items.product_name}
          column: users_gender {field:users.gender}
          column: inventory_items_product_category {field:inventory_items.product_category}
          column: order_items_total_sales {field:order_items.total_sales}
          column: order_items_count {field:order_items.count}
        }
      }
      dimension: inventory_items_product_name {hidden:yes label:"Product Name"}
      dimension: users_gender {hidden:yes label:"Gender"}
      dimension: inventory_items_product_category {hidden:yes label:"Product Category"}
      measure: order_items_total_sales {hidden:yes type:sum }#sql:${TABLE}.order_items_total_sales;;}
      measure: order_items_count {hidden:yes type:sum }#sql:${TABLE}.order_items_count;;}
    }


    view: tile_2_ndt_order_items {
      measure: total_sales{ type: number label:"Total Sales"
        sql: ${tile_2_ndt.order_items_total_sales};;
      }
      measure: count{ type: number label:"Count"
        sql: ${tile_2_ndt.order_items_count};;
      } }

    view: tile_2_ndt_users {
      dimension: gender {
        type:string
        sql: ${tile_2_ndt.users_gender};;
      }}

    view: tile_2_ndt_inventory_items {
      dimension: product_name {
        type:string
        sql: ${tile_2_ndt.inventory_items_product_name};;
      }
      dimension: product_category {
        type:string
        sql: ${tile_2_ndt.inventory_items_product_category};;
      }}

    explore: tile_2_ndt {
      join: order_items {from: tile_2_ndt_order_items sql:;; relationship: one_to_one}
    join: users {from: tile_2_ndt_users sql:;; relationship: one_to_one}
  join: inventory_items {from: tile_2_ndt_inventory_items sql:;; relationship: one_to_one}
}
####
      view: tile_3_ndt {
        derived_table: {
          explore_source: order_items {
            column: inventory_items_product_brand {field:inventory_items.product_brand}
            column: order_items_status {field:order_items.status}
            column: users_count {field:users.count}
            column: order_items_count {field:order_items.count}
          }
        }
        dimension: inventory_items_product_brand {hidden:yes type:string label:"Product Brand"}
        dimension: order_items_status {hidden:yes type:string label:"Status"}
        measure: users_count {hidden:yes type:sum}
        measure: order_items_count {hidden:yes type:sum}
      }


      view: tile_3_ndt_order_items {
        dimension: status {
          type:string
          sql: ${tile_3_ndt.order_items_status};;
        }
        measure: count{ type: number label:"Count"
          sql: ${tile_3_ndt.order_items_count};;
        } }

      view: tile_3_ndt_inventory_items {
        dimension: product_brand {
          type:string
          sql: ${tile_3_ndt.inventory_items_product_brand};;
        }}

      view: tile_3_ndt_users {
        measure: count{ type: number label:"Count"
          sql: ${tile_3_ndt.users_count};;
        } }

      explore: tile_3_ndt {
        join: order_items {from: tile_3_ndt_order_items sql:;; relationship: one_to_one}
      join: inventory_items {from: tile_3_ndt_inventory_items sql:;; relationship: one_to_one}
    join: users {from: tile_3_ndt_users sql:;; relationship: one_to_one}
}

        view: look_500_ndt {
          derived_table: {
            explore_source: order_items {
              column: inventory_items_product_brand {field:inventory_items.product_brand}
              column: order_items_status {field:order_items.status}
              column: users_count {field:users.count}
              column: order_items_count {field:order_items.count}
            }

#           persist_for: "1 hour"
#           distribution_style: all
          }



          dimension: inventory_items_product_brand {hidden:yes label:"Product Brand"}
          dimension: order_items_status {hidden:yes label:"Status"}
          measure: users_count {hidden:yes type:sum}
          measure: order_items_count {hidden:yes type:sum}
        }


        view: look_500_ndt_order_items {
          dimension: status {
            type:string
            sql: ${look_500_ndt.order_items_status};;
          }
          measure: count{ type: number label:"Count"
            sql: ${look_500_ndt.order_items_count};;
          } }

        view: look_500_ndt_inventory_items {
          dimension: product_brand {
            type:string
            sql: ${look_500_ndt.inventory_items_product_brand};;
          }}

        view: look_500_ndt_users {
          measure: count{ type: number label:"Count"
            sql: ${look_500_ndt.users_count};;
          } }

        explore: look_500_ndt {
          join: order_items {from: look_500_ndt_order_items sql:;; relationship: one_to_one}
        join: inventory_items {from: look_500_ndt_inventory_items sql:;; relationship: one_to_one}
      join: users {from: look_500_ndt_users sql:;; relationship: one_to_one}
  }


####
          view: look_501_ndt {
            derived_table: {
              explore_source: order_items {
                column: users_zip {field:users.zip}
                column: inventory_items_cost {field:inventory_items.cost}
                column: users_state {field:users.state}
                column: order_items_total_sales {field:order_items.total_sales}
              }

              persist_for: "1 hour"
              distribution_style: all
            }
            dimension: users_zip {hidden:yes label:"Zip"}
            dimension: inventory_items_cost {hidden:yes label:"Cost"}
            dimension: users_state {hidden:yes label:"State"}
            measure: order_items_total_sales {hidden:yes type:sum}
          }


          view: look_501_ndt_order_items {
            measure: total_sales{ type: number label:"Total Sales"
              sql: ${look_501_ndt.order_items_total_sales};;
            } }

          view: look_501_ndt_users {
            dimension: zip {
              type:zipcode
              sql: ${look_501_ndt.users_zip};;
            }
            dimension: state {
              type:string
              sql: ${look_501_ndt.users_state};;
            }}

          view: look_501_ndt_inventory_items {
            dimension: cost {
              type:number
              sql: ${look_501_ndt.inventory_items_cost};;
            }}

          explore: look_501_ndt {
            join: order_items {from: look_501_ndt_order_items sql:;; relationship: one_to_one}
          join: users {from: look_501_ndt_users sql:;; relationship: one_to_one}
        join: inventory_items {from: look_501_ndt_inventory_items sql:;; relationship: one_to_one}
    }
####
              view: look_502_ndt {
                derived_table: {
                  explore_source: order_items {
                    column: user_lifetime_summary_lifetime_order_count {field:user_lifetime_summary.lifetime_order_count}
                    column: order_items_average_sale_price {field:order_items.average_sale_price}
                    column: order_items_count {field:order_items.count}
                  }
                }
                dimension: user_lifetime_summary_lifetime_order_count {hidden:yes label:"Lifetime Order Count"}
                measure: order_items_average_sale_price {hidden:yes type:max}
                measure: order_items_count {hidden:yes type:max}
              }


              view: look_502_ndt_user_lifetime_summary {
                dimension: lifetime_order_count {
                  type:string
                  sql: ${look_502_ndt.user_lifetime_summary_lifetime_order_count};;
                }}

              view: look_502_ndt_order_items {
                measure: average_sale_price{ type: number label:"Average Sale Price"
                  sql: ${look_502_ndt.order_items_average_sale_price};;
                }
                measure: count{ type: number label:"Count"
                  sql: ${look_502_ndt.order_items_count};;
                } }

              explore: look_502_ndt {
                join: user_lifetime_summary {from: look_502_ndt_user_lifetime_summary sql:;; relationship: one_to_one}
              join: order_items {from: look_502_ndt_order_items sql:;; relationship: one_to_one}
          }

###
                view: look_503_ndt {
                  derived_table: {
                    explore_source: order_items {
                      column: user_lifetime_summary_lifetime_order_count {field:user_lifetime_summary.lifetime_order_count}
                      column: order_items_status {field:order_items.status}
                      column: order_items_average_sale_price {field:order_items.average_sale_price}
                      column: order_items_count {field:order_items.count}
                    }
                  }
                  dimension: user_lifetime_summary_lifetime_order_count {hidden:yes label:"Lifetime Order Count"}
                  dimension: order_items_status {hidden:yes label:"Status"}
                  measure: order_items_average_sale_price {hidden:yes type:max}
                  measure: order_items_count {hidden:yes type:max}
                }


                view: look_503_ndt_user_lifetime_summary {
                  dimension: lifetime_order_count {
                    type:string
                    sql: ${look_503_ndt.user_lifetime_summary_lifetime_order_count};;
                  }}

                view: look_503_ndt_order_items {
                  dimension: status {
                    type:string
                    sql: ${look_503_ndt.order_items_status};;
                  }
                  measure: average_sale_price{ type: number label:"Average Sale Price"
                    sql: ${look_503_ndt.order_items_average_sale_price};;
                  }
                  measure: count{ type: number label:"Count"
                    sql: ${look_503_ndt.order_items_count};;
                  } }

                explore: look_503_ndt {
                  join: user_lifetime_summary {from: look_503_ndt_user_lifetime_summary sql:;; relationship: one_to_one}
                join: order_items {from: look_503_ndt_order_items sql:;; relationship: one_to_one}
            }
