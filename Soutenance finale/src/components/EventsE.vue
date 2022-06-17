<template>
  <div class="card mb-5">
    <div class="card-header text-white bg-secondary mb-3 py-2 px-3">
      <h5>Events</h5>
    </div>
    <div class="card-body overflow-auto">
      <div class="hori-timeline" dir="ltr">
        <hr class="line-before" />
        <ul class="list-inline events">
          <li
            class="list-inline-item event-list"
            v-for="event in events"
            :key="event.id"
          >
            <div class="px-4">
              <div class="event-date bg-soft-primary text-primary">
                {{ event.annee }}
              </div>
              <h5 class="font-size-12 event_type">{{ event.type_event }}</h5>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "EventsE",
  data() {
    return {
      events: [],
    };
  },

  mounted() {
    axios
      .get("http://localhost:5000/events")
      .then((resp) => (this.events = resp.data));
  },
};
</script>
