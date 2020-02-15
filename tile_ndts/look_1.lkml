include: "/views/order_items.view"
view: tile_1_ndt {
  derived_table: {
    explore_source: order_items {
      column: brand {field:products.brand}
      column: count {field:products.count}
      column: gender {field:users.gender}
    }

  }
  dimension: brand {hidden:yes}
  dimension: gender {hidden:yes}
  measure: count {hidden: yes
    type: sum
    sql: ${TABLE}.count ;;
  }
}

view: tile_1_ndt_order_items {
  extends: [order_items]
  set: ndt_fields {fields:[]}
}


include: "/views/products.view"
view: tile_1_ndt_products {
  extends: [products]
  dimension: brand {
    sql: ${tile_1_ndt.brand} ;;
  }
  measure: count {
    type: number
    sql: ${tile_1_ndt.count} ;;
  }
  set: ndt_fields {fields:[brand,count]}
}

include: "/views/users.view"
view: tile_1_ndt_users {
  extends: [users]
  dimension: gender {
    sql: ${tile_1_ndt.gender} ;;
  }
  set: ndt_fields {fields:[gender]}
}

explore: tile_1_ndt {
  join: order_items {
    from: tile_1_ndt_order_items
    fields: [ndt_fields*]
    sql: ;;
    relationship: one_to_one
  }
  join: products {
    from: tile_1_ndt_products
    fields: [ndt_fields*]
    sql: ;;
    relationship: one_to_one
  }
  join: users {
    from: tile_1_ndt_users
    fields: [ndt_fields*]
    sql: ;;
  relationship: one_to_one
  }
}
