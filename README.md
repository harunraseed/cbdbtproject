Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test

### Building the menu dimension and order items

The menu dimension exposes `menu_item_sk`; the order-items fact aliases that
key as `menu_item_key`. Brand categories come from the `truck_brand_category`
seed through a left join, retaining menu items without a matching category.

To load the lookup and rebuild the dimension and its downstream fact:

```powershell
dbt seed --select truck_brand_category
dbt build --select dim_menu+
```

This does not rebuild `fct_orders`; it uses the existing orders table.

### Rebuilding orders after a schema change

`fct_orders` is incremental and uses a three-day lookback. If its output
columns change, the existing Snowflake table must be rebuilt so historical
orders receive the new columns and dimension keys.

Run from the project directory:

```powershell
dbt build --full-refresh --select fct_orders+
```

This rebuilds `fct_orders` and its downstream models and runs their tests.
It reads all orders allowed by the staging filter, replaces the existing
orders table, and consumes Snowflake compute.

The model uses `on_schema_change='fail'` to report schema mismatches explicitly
rather than attempting a merge against outdated columns. Automatically adding
columns would not populate them for historical rows outside the lookback window.


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
