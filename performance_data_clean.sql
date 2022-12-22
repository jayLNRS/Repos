-- psql -q -h hostname -p 5432 -U insight -d platform -v ON_ERROR_STOP=1 -v org_id=281 -f performance_data_clean.sql

SET work_mem TO '262144';
SET myvars.orgid TO :org_id;
SET session_replication_role = replica;

do
$$
declare
  org_can_be_deleted boolean;
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
  _org_name VARCHAR;

begin

  select count(*) > 0
  from "Organisations" o
  where o."Id" = _org_id and o."Name" like '%Testing%'
  into org_can_be_deleted;

  select o."Name"
  from "Organisations" o
  where o."Id" = _org_id
  into _org_name;

  if not org_can_be_deleted then
    raise exception 'Supplied orgId % (%) does not exist or is not a testing org.', _org_id, _org_name;
  end if;

  raise notice 'Deleting data for OrgId % (%s)...', _org_id, _org_name;

  with del as (
    delete from "AccountApplications" aa where aa."OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'AccountApplications: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "AccountCompanyFees" acf where acf."OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'AccountCompanyFees: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "AccountCompanyProducts" acp where acp."OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'AccountCompanyProducts: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
     delete from "Companies" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'Companies: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "Company" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'Company: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
     delete from "Accounts" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'Accounts: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "Aliases" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'Aliases: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "Addresses" ad
    using "Residencies" r, "Applicants" a
    where a."Id" = r."OwnerId"
    and r."AddressId" = ad."Id"
    and a."OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'Addresses: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "Residencies" r
    using "Applicants" a
    where a."Id" = r."OwnerId"
    and a."OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'Residencies: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "IDs" ids
    using "Applicants" a
    where ids."OwnerId" = a."Id"
    and a."OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'IDs: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "TaxRegulations" tr
    using "Applicants" a
    where tr."OwnerId" = a."Id"
    and a."OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'TaxRegulations: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
     delete from "Applicants" a where a."OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'Applicants: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "AppRunAlerts" ara
    using "AppRuns" ar, "Applications" a
    where ara."AppRunId" = ar."Id"
    and ar."ApplicationId" = a."Id"
    and a."OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'AppRunAlerts: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "BatchRulesets" br
    using "AppRuns" ar, "Applications" a
    where br."RunId" = ar."RunId"
    and a."Id" = ar."ApplicationId"
    and a."OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'BatchRulesets: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  -- Doing 2 deletes because suspected data inconsistency between "BatchRuns" and "Rules"

  with del as (
    delete from "BatchRunRules" brr
    using "BatchRuns" br
    where br."OrgId" = _org_id
    and br."Id" = brr."RunId"
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'BatchRunRules (RunId): Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

  with del as (
    delete from "BatchRunRules" brr
    using "Rules" r
    where r."OrgId" = _org_id
    and brr."RuleId" = r."Id"
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'BatchRunRules (RuleId): Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "AppRuns" ar
    using "Applications" a
    where ar."ApplicationId" = a."Id"
    and a."OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'AppRuns: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "ApplicationDecisions" ad
    using "Applications" a
    where ad."ApplicationId" = a."Id"
    and a."OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'ApplicationDecisions: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "ApplicationRuns" ar
    using "Applications" a
    where ar."ApplicationId" = a."Id"
    and a."OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'ApplicationRuns: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "ApplicationsWatchlist" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'ApplicationsWatchlist: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "AppsFact" where "OrgId" = _org_id::varchar
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'AppsFact: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "AssetTypes" ast where ast."OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'AssetTypes: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "CondAttributesDim" cad
    using "Applications" a
    where cad."ApplicationId" = a."Id"
    and a."OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'CondAttributesDim: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "Assets" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'Assets: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "BankAccounts"  where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'BankAccounts: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "ApplicationFact" where "OrgId" = _org_id::varchar
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'ApplicationFact: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "OrganisationConsortia" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'OrganisationConsortia: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "Consortia" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'Consortia: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "DrivingLicences" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'DrivingLicences: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "ExternalRuleOutcomes" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'ExternalRuleOutcomes: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "FinancialAccounts" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'FinancialAccounts: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "FinancialTransactions" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'FinancialTransactions: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "FunctionCalls" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'FunctionCalls: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "FundingCountries" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'FundingCountries: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "GoodsOrderItems" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'GoodsOrderItems: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "GoodsOrders" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'GoodsOrders: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "GoodsAccounts" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'GoodsAccounts: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "LegalThirdParties" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'LegalThirdParties: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "MatchOutcomeFact" where "OwnerOrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'MatchOutcomeFact: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "MotorDetails" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'MotorDetails: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "Passports" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'Passports: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "PaymentCards" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'PaymentCards: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "PaymentProfile" pp
    using "Applications" a
    where pp."ApplicationId" = a."Id"
    and a."OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'PaymentProfile: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "PaymentsAccounts" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'PaymentsAccounts: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "ProductNames" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'ProductNames: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "ProductOfferings" po
    using "Applications" a
    where po."ApplicationId" = a."Id"
    and a."OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'ProductOfferings: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "Products" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'Products: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "RuleFunctionCalls" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'RuleFunctionCalls: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "Rules" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'Rules: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "BatchRuns" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'BatchRuns: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "RuleOutcomeMatches" rom
    using "Applications" a
    where rom."OwnerId" = a."Id"
    and a."OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'RuleOutcomeMatches: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "RuleOutcomes" ro
    using "Applications" a
    where ro."OwnerId" = a."Id"
    and a."OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'RuleOutcomes: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "RulesAnalysis" ra where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'RulesAnalysis: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "RulesFact" where "OrgId" = _org_id::varchar
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'RulesFact: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;


do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "RulesetRunnerConfig" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'RulesetRunnerConfig: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;


do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "Rulesets" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'Rulesets: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;


do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "SalesAgents" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'SalesAgents: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "SourceData" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'SourceData: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "Statistics" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'Statistics: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "TradingCurrencies" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'TradingCurrencies: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "Transactions" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'Transactions: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "TransactionsWatchlist" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'TransactionsWatchlist: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "UserDefineds" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'UserDefineds: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "Valuer" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'Valuer: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;

do
$$
declare
  _org_id BIGINT := current_setting( 'myvars.orgid', true );
  _deleted INTEGER;
begin

  with del as (
    delete from "Applications" where "OrgId" = _org_id
    returning *
  )
  select count(*) from del into _deleted;

  raise notice 'Applications: Deleted % rows in %',
    _deleted, age( clock_timestamp(), now() );

end;
$$;
