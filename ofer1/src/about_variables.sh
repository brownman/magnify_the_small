# About environment variables

green "Variables"

test_setting_the_variable() {
  local variable=1
  assertEqual 1 1
}

test_using_double_quotes() {
  local variable=2
  assertEqual "foo $variable" 'foo 2'
}

test_unsetting_variables() {
  local newVariable="Foooo"
  unset newVariable
  assertEqual $newVariable '' 
}

# Variables defined in global namespace are available everywhere
THIS_VARIABLE_IS_GLOBAL=42
test_global_variables() {
  assertEqual $THIS_VARIABLE_IS_GLOBAL 42
}

# In this function we define a global variable, it becomes available outside
function_with_a_global_variable() {
  THIS_VARIABLE_IS_GLOBAL_FROM_A_FUNCTION=42
}
# Run the function
function_with_a_global_variable

test_global_variables_from_functions() {
  assertEqual $THIS_VARIABLE_IS_GLOBAL_FROM_A_FUNCTION 42
}

# In this function we define a local variable, it is not accessible outside
function_with_a_local_variable() {
  local THIS_VARIABLE_IS_LOCAL=42
}
# Run the function
function_with_a_local_variable

test_local_variables() {
  assertEqual $THIS_VARIABLE_IS_LOCAL ''
}

test_variable_name_expansion_within_text() {
  local var1=myvar

  # __ = this_is_myvar_yay
  assertEqual this_is_${var1}_yay 'this_is_myvar_yay'

}

test_only_exported_variables_are_accessible_by_another_process() {
  local MY_EXPORTED_VARIABLE=43

  assertEqual `bin/variable_check` ''

  MY_EXPORTED_VARIABLE=43

  assertEqual `bin/variable_check` '' 

  export MY_EXPORTED_VARIABLE=43

  assertEqual `bin/variable_check` '43'
}

