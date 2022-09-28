<!--
  This example requires Tailwind CSS v2.0+

  This example requires some changes to your config:

  ```
  // tailwind.config.js
  module.exports = {
    // ...
    plugins: [
      // ...
      require('@tailwindcss/forms'),
    ],
  }
  ```
-->
<template>
  <!--
    This example requires updating your template:

    ```
    <html class="h-full">
    <body class="h-full">
    ```
  -->
  <div>
    <TransitionRoot :show="sidebarOpen" as="template">
      <Dialog as="div" class="relative z-40 md:hidden" @close="sidebarOpen = false">
        <TransitionChild as="template" enter="transition-opacity ease-linear duration-300" enter-from="opacity-0"
                         enter-to="opacity-100" leave="transition-opacity ease-linear duration-300"
                         leave-from="opacity-100" leave-to="opacity-0">
          <div class="fixed inset-0 bg-gray-600 bg-opacity-75"/>
        </TransitionChild>

        <div class="fixed inset-0 z-40 flex">
          <TransitionChild as="template" enter="transition ease-in-out duration-300 transform"
                           enter-from="-translate-x-full" enter-to="translate-x-0"
                           leave="transition ease-in-out duration-300 transform" leave-from="translate-x-0"
                           leave-to="-translate-x-full">
            <DialogPanel class="relative flex w-full max-w-xs flex-1 flex-col bg-white pt-5 pb-4">
              <TransitionChild as="template" enter="ease-in-out duration-300" enter-from="opacity-0"
                               enter-to="opacity-100" leave="ease-in-out duration-300" leave-from="opacity-100"
                               leave-to="opacity-0">
                <div class="absolute top-0 right-0 -mr-12 pt-2">
                  <button
                      class="ml-1 flex h-10 w-10 items-center justify-center rounded-full focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white"
                      type="button"
                      @click="sidebarOpen = false">
                    <span class="sr-only">Close sidebar</span>
                    <XMarkIcon aria-hidden="true" class="h-6 w-6 text-white"/>
                  </button>
                </div>
              </TransitionChild>
              <div class="flex flex-shrink-0 items-center px-4">
                <img alt="Your Company" class="h-8 w-auto"
                     src="https://tailwindui.com/img/logos/mark.svg?color=indigo&shade=600"/>
              </div>
              <div class="mt-5 h-0 flex-1 overflow-y-auto">
                <nav class="space-y-1 px-2">
                  <RouterLink v-for="item in navigation" :key="item.name"
                              :class="[item.current ? 'bg-gray-100 text-gray-900' : 'text-gray-600 hover:bg-gray-50 hover:text-gray-900', 'group rounded-md py-2 px-2 flex items-center text-base font-medium']"
                              :to="item.to">
                    <component :is="item.icon"
                               :class="[item.current ? 'text-gray-500' : 'text-gray-400 group-hover:text-gray-500', 'mr-4 flex-shrink-0 h-6 w-6']"
                               aria-hidden="true"/>
                    {{ item.name }}
                  </RouterLink>
                </nav>
              </div>
            </DialogPanel>
          </TransitionChild>
          <div class="w-14 flex-shrink-0">
            <!-- Dummy element to force sidebar to shrink to fit close icon -->
          </div>
        </div>
      </Dialog>
    </TransitionRoot>

    <!-- Static sidebar for desktop -->
    <div class="hidden md:fixed md:inset-y-0 md:flex md:w-64 md:flex-col">
      <!-- Sidebar component, swap this element with another sidebar if you like -->
      <div class="flex flex-grow flex-col overflow-y-auto border-r border-gray-200 bg-white pt-5">
        <div class="flex flex-shrink-0 items-center px-4">
          <img alt="Your Company" class="h-8 w-auto"
               src="https://tailwindui.com/img/logos/mark.svg?color=indigo&shade=600"/>
        </div>
        <div class="mt-5 flex flex-grow flex-col">
          <nav class="flex-1 space-y-1 px-2 pb-4">
            <RouterLink v-for="item in navigation" :key="item.name"
                        :class="[item.current ? 'bg-gray-100 text-gray-900' : 'text-gray-600 hover:bg-gray-50 hover:text-gray-900', 'group rounded-md py-2 px-2 flex items-center text-sm font-medium']"
                        :to="item.to">
              <component :is="item.icon"
                         :class="[item.current ? 'text-gray-500' : 'text-gray-400 group-hover:text-gray-500', 'mr-3 flex-shrink-0 h-6 w-6']"
                         aria-hidden="true"/>
              {{ item.name }}
            </RouterLink>
          </nav>
        </div>
      </div>
    </div>

    <div class="md:pl-64">
      <div class="mx-auto flex max-w-4xl flex-col md:px-8 xl:px-0">
        <div class="sticky top-0 z-10 flex h-16 flex-shrink-0 border-b border-gray-200 bg-white">
          <button
              class="border-r border-gray-200 px-4 text-gray-500 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-indigo-500 md:hidden"
              type="button"
              @click="sidebarOpen = true">
            <span class="sr-only">Open sidebar</span>
            <Bars3BottomLeftIcon aria-hidden="true" class="h-6 w-6"/>
          </button>
          <div class="flex flex-1 justify-between px-4 md:px-0">
            <div class="flex flex-1">
              <div class="grid content-center">
                <h1 class="font-bold text-2xl">Getting Started</h1>
              </div>
            </div>
            <div class="ml-4 flex items-center md:ml-6">
              <button
                  class="rounded-full bg-white p-1 text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
                  type="button">
                <span class="sr-only">View notifications</span>
                <BellIcon aria-hidden="true" class="h-6 w-6"/>
              </button>

              <!-- Profile dropdown -->
              <Menu as="div" class="relative ml-3">
                <div>
                  <MenuButton
                      class="flex max-w-xs items-center rounded-full text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">
                    <span class="sr-only">Open user menu</span>
                    <img alt=""
                         class="h-8 w-8 rounded-full"
                         src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"/>
                  </MenuButton>
                </div>
                <transition enter-active-class="transition ease-out duration-100"
                            enter-from-class="transform opacity-0 scale-95"
                            enter-to-class="transform opacity-100 scale-100"
                            leave-active-class="transition ease-in duration-75"
                            leave-from-class="transform opacity-100 scale-100"
                            leave-to-class="transform opacity-0 scale-95">
                  <MenuItems
                      class="absolute right-0 z-10 mt-2 w-48 origin-top-right rounded-md bg-white py-1 shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none">
                    <MenuItem v-for="item in userNavigation" :key="item.name" v-slot="{ active }">
                      <a :class="[active ? 'bg-gray-100' : '', 'block py-2 px-4 text-sm text-gray-700']"
                         :href="item.href">{{
                          item.name
                        }}</a>
                    </MenuItem>
                  </MenuItems>
                </transition>
              </Menu>
            </div>
          </div>
        </div>

        <main class="flex-1">
          <div class="py-6">
            <div class="px-4 sm:px-6 md:px-0">
              <!-- Replace with your content -->
              <div class="py-4">
                <div class="flex justify-center">
                  <RouterView/>
                </div>

              </div>
              <!-- /End replace -->
            </div>
          </div>
        </main>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import {
  Dialog,
  DialogPanel,
  Menu,
  MenuButton,
  MenuItem,
  MenuItems,
  TransitionChild,
  TransitionRoot,
} from '@headlessui/vue'
import {
  Bars3BottomLeftIcon,
  BellIcon,
  CalendarIcon,
  ChartBarIcon,
  FolderIcon,
  HomeIcon,
  InboxIcon,
  UsersIcon,
  XMarkIcon,
} from '@heroicons/vue/24/outline'
import { MagnifyingGlassIcon } from '@heroicons/vue/20/solid'

const navigation = [
  {name: 'Home', to: '/', icon: HomeIcon, current: true},
  {name: 'Getting Started', to: 'start', icon: UsersIcon, current: false},
  {name: 'What\s New', to: '#', icon: FolderIcon, current: false},
  {name: 'Guidelines', to: '#', icon: CalendarIcon, current: false},
  {name: 'Design Tokens', to: '#', icon: InboxIcon, current: false},
  {name: 'Components', to: '#', icon: ChartBarIcon, current: false},
  {name: 'CSS Framework', to: '#', icon: InboxIcon, current: false},
  {name: 'Nordicons', to: '#', icon: ChartBarIcon, current: false},
]
const userNavigation = [
  {name: 'Your Profile', to: '#'},
  {name: 'Settings', to: '#'},
  {name: 'Sign out', to: '#'},
]

const sidebarOpen = ref(false)
</script>