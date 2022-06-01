<template>
  <label
    :for="fieldId"
    class="flex flex-row items-center font-bold cursor-pointer"
  >
    <input type="checkbox" :id="fieldId" class="mr-2" />{{ label }}
  </label>
</template>
<script>
export default {
  props: {
    label: String,
    fieldId: {
      type: String,
      required: false,
    },
    checked: {
      type: Boolean,
    },
  },
};
</script>
