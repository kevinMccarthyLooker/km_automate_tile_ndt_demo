include: "/views/products.view"
view: tile_1_ndt {
  derived_table: {
    explore_source: order_items {
      column: brand {field:products.brand}
      column: count {field:products.count}
      column: gender {field:users.gender}
    }

  }
  dimension: brand {}
  dimension: gender {}
  measure: count {
    hidden: yes
    type: sum
  }
}
view: tile_1_ndt_products {
  extends: [products]
  dimension: brand {
    sql: ${order_items.brand} ;;
  }
  measure: count {
    type: number
    sql: ${order_items.count} ;;
  }
  set: ndt_fields {fields:[brand,count]}
}
view: tile_1_ndt_users {
  dimension: gender {
    sql: ${order_items.gender} ;;
  }
}

explore: tile_1_ndt {
  from: tile_1_ndt
  view_name: order_items
  join: products {
    from: tile_1_ndt_products
    fields: [ndt_fields*]
    sql: ;;
    relationship: one_to_one
  }
  join: users {
    from: tile_1_ndt_users
    sql: ;;
  relationship: one_to_one
  }
}
