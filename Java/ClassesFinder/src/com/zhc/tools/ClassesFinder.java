package com.zhc.tools;

import java.util.Set;

import org.reflections.Reflections;

/**
 * Find all classes or interfaces that extends or implements a super type.
 * Author: Hongchang
 */
public class ClassesFinder {
    /**
     * args[0] is the class or interface name such as com.zhc.services.VerificationService
     * @param args
     * @throws Exception
     */
    public static void main(String[] args) throws Exception {
        Reflections reflections = new Reflections(".*");
        Class clazz = Class.forName(args[0]);

        Set<Class> subClasses = reflections.getSubTypesOf(clazz);
        for (Class c : subClasses) {
            System.out.println(c.getCanonicalName());
        }
    }
}